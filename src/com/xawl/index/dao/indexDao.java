package com.xawl.index.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import cn.itcast.jdbc.TxQueryRunner;

import com.xawl.index.domain.index;

public class indexDao {
		private QueryRunner qr=new TxQueryRunner();
		
		//查找所有的非图片字段
	public List<index> findByInfo() throws SQLException{
		String sql="select * from indexs where isImage=0";//取0代表非图片  1代表图片
		return qr.query(sql,new BeanListHandler<index>(index.class));
	}
	//删除字段
	public Boolean ajaxremoveInfo(String iId) throws SQLException{
		String sql="delete from indexs where iId=?";
		return qr.update(sql,iId)==0?false:true;
	}
	//编辑
	public Boolean editInfo(index i) throws SQLException {
		String sql="update indexs set iName=?,iValue=? where iId=?";
		return qr.update(sql,i.getiName(),i.getiValue(),i.getiId())==0?false:true;
	}
	//添加
	public Boolean addInfo(index x) throws SQLException{
		String sql="insert into indexs values(?,?,?,?,?)";
	return	qr.update(sql,x.getiId(),x.getiName(),x.getiValue(),x.getIsImage(),x.getiLocation())==0?false:true;
	}
	//查询大图
	public List<index>findByMaxImage(String image) throws SQLException{
		String sql="select * from indexs where isImage=? order by iLocation	ASC";
		return qr.query(sql, new BeanListHandler<index>(index.class),image);	
	}

	//iid查询
	public index findByiId(String image) throws SQLException{
		String sql="select * from indexs where iId=?";
		return qr.query(sql, new BeanHandler<index>(index.class),image);	
	}
	//重命名
	public Boolean ajaxeditImage(String iName,String iId) throws SQLException{
		String sql="update indexs set iName=? where iId=?";
		return qr.update(sql,iName,iId)==0?false:true;
		
	}
	//覆盖小图
	public void	 editMinImage(String Location,String iValue,String iName,String iId) throws SQLException{
		String sql="update indexs set iLocation=?,iValue=?,iName=? where iId=?";
		qr.update(sql,Location,iValue,iName,iId);
		
	}
	//查是否已经存在该位置的图
	public index findisLocation(String ilocation) throws SQLException{
		String sql="select * from indexs where iLocation=?";
		return qr.query(sql, new BeanHandler<index>(index.class),ilocation);
	}
	
}
