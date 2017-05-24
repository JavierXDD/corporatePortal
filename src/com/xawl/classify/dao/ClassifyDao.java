package com.xawl.classify.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;
import cn.itcast.commons.CommonUtils;
import cn.itcast.jdbc.TxQueryRunner;

import com.xawl.classify.domain.Classify;

/*
 * 
 */
public class ClassifyDao {
	private QueryRunner qr=new TxQueryRunner();
	
	/*
	 * 查找所有分级菜单返回集合
	 */
	/*public  List<Classify> findAll() throws SQLException{
		//先查找到所有的一级菜单
		String sql="select * from classify where pId is null";
		List<Classify> classifylistroot=isClassifylist(qr.query(sql, new MapListHandler()));  //他返回的是List<Map<String,Object>>(); 
		//classifylist返回的是所有的一级。接下来想办法找二级    设classifylistroot为根节
		//Show.show(classifylistroot);
		List<Classify> result=new ArrayList<Classify>();
			for(Classify ify:classifylistroot){
				Classify c=find(ify.getcId());
				result.add(c);
			}
		return result;
	}
	*/
	//查找1 2级菜单
	public  List<Classify> findAll() throws SQLException{
		String sql="select * from classify where pId is null";
		List<Classify> classifylistroot=isClassifylist(qr.query(sql, new MapListHandler()));  //他返回的是List<Map<String,Object>>(); 
		for(Classify list:classifylistroot){
			//子类
			List<Classify> childlist=findBy2(list.getcId());
			for(Classify child:childlist){
				Classify s=new Classify();
				s.setcId(list.getcId());
				s.setcName(list.getcName());
				child.setParents(s);
			}
			list.setChildren(childlist);
			
		}
		return classifylistroot;
	}
	
	//查找一级菜单
	public List<Classify> findByParent() throws SQLException{
		String sql="select * from classify where pId is null";
		List<Classify> classifylistroot=isClassifylist(qr.query(sql, new MapListHandler())); 
		return classifylistroot;
	}
	//查找一级菜单  ajax版  后期考虑合并一下
	public List<Map<String,Object>> findByParent2() throws SQLException{
		String sql="select * from classify where pId is null";
		List<Map<String,Object>>list=qr.query(sql, new MapListHandler());
		return list;
	}
	
	//查找新闻类下面的二级菜单  鉴于后面的功能 我们需要打包二级菜单
	public List<Classify> findBy2(String cid) throws SQLException{
		String sql="select * from classify where pId=?";
//		List<Classify> list=qr.query(sql, new BeanListHandler<Classify>(Classify.class),cid);
		List<Classify> list=isClassifylist(qr.query(sql, new MapListHandler(),cid)); 
		return list;
	}
	
	private Classify find(String cid) throws SQLException{  //找一条线上的所有的节点
			Classify node=findByid(cid);
			List<Classify> child=toChildList(node.getcId());
			for(Classify ify:child){
				Classify i=find(ify.getcId());
				node.setChildren(new ArrayList<Classify>());
				node.getChildren().add(i);
			}
			return node;
	}
	// 数组0下标问题
	public Classify findByid(String id) throws SQLException{
		String sql="select * from classify where cId=?";   //所有必需保证CID是唯一的标示
		List<Map<String,Object>> list=qr.query(sql, new MapListHandler(),id);
		if(list!=null){
			return isClassify(qr.query(sql, new MapListHandler(),id).get(0));
		}else{
			return null;
		}
	
	//	return qr.query(sql, new BeanHandler<Classify>(Classify.class),id);
	}
	
	private List<Classify>isClassifylist(List<Map<String,Object>>maplist) throws SQLException{    //上面那返回的是list map需要转成 list bean
			List<Classify> classify=new ArrayList<Classify>();
			for(Map<String,Object> item :maplist){  //循环转成bean
				Classify tiems=isClassify(item);
				classify.add(tiems);
			}
			return classify;
	}
	
	private Classify isClassify(Map<String,Object> map) throws SQLException{      //先把map转换成对象，因为和表不对应，pid的手动加进去
		Classify classify=CommonUtils.toBean(map, Classify.class);
		if(map.get("pId")!=null) //！=null  说明是二级以下的菜单  那么他就有pid这个属性，要保存起来
		{	
			//添加父类
		Classify c=	this.findByid((String)map.get("pId"));
		classify.setParents(c);
		}
		return classify;
	}
	 //给我一个父类，我帮你找到他的下一级
	private List<Classify> toChildList(String id) throws SQLException{
		String sql="select * from classify where pId=?";
		return isClassifylist(((qr.query(sql, new MapListHandler(),id))));
}
	//ajax返回前台的新闻类型  之前的只返回Cname  不好，修改为返回cid  cname  需要我们手动转换为json
	public List<Map<String, Object>> ajaxfindByCid(String cid) throws SQLException{
			String sql="select cName,cId from classify where pId=?";
			List<Map<String, Object>> list=qr.query(sql, new MapListHandler(),cid);
		
			return list;
	}
	
	//修改一级菜单的名字和描述
	public Boolean ajaxeditFirstMenu(String cName,String desc,String cid) throws SQLException{
			
			String sql="update classify set cName=?,cDesc=? where cId=?";
			return qr.update(sql,cName,desc,cid)==0?false:true;
	}
	
	//修改二级菜单的信息 
	public Boolean ajaxeditTwoMenu(String cName,String desc,String pid,String cid) throws SQLException{
		
		String sql="update classify set cName=?,cDesc=?,pId=? where cId=?";
		return qr.update(sql,cName,desc,pid,cid)==0?false:true;
}
	//删除二级菜单
public Boolean ajaxremoveMenu(String cid) throws SQLException{
		String sql="delete from classify where cId=?";
		return qr.update(sql,cid)==0?false:true;
	
}
//添加二级分类
public void  addTwoMenu(Classify c) throws SQLException{
	String sql="insert into classify values(?,?,?,?,?,?)";
	Object[]param={c.getcId(),c.getcName(),c.getParents().getcId(),c.getcAddr(),c.getIsUse(),c.getcDesc()};
	qr.update(sql,param);
}
	
}
