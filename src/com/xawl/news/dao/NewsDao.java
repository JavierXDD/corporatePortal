package com.xawl.news.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.itcast.commons.CommonUtils;
import cn.itcast.jdbc.TxQueryRunner;

import com.xawl.Users.domain.Users;
import com.xawl.classify.dao.ClassifyDao;
import com.xawl.classify.domain.Classify;
import com.xawl.news.domain.News;
import com.xawl.news.domain.PageBean;

public class NewsDao {

	private QueryRunner qr = new TxQueryRunner();
	private ClassifyDao classifydao=new ClassifyDao();

	// 获取cName的cid
	public String findCidByCname(String cname) {
		try {
			String sql = "select cId from classify where cName = ?";
			Classify classify = qr.query(sql, new BeanHandler<Classify>(
					Classify.class), cname);
			return String.valueOf(classify.getcId());
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	// 添加新闻
	public void addNews(News news) {
		try {
			String sql = "insert into news values(?,?,?,?,?,?,?,?)";
			Object[] params = { news.getnId(), news.getnTheme(),
					news.getnTime(), news.getnEditors().getuId(),
					news.getnTypes().getcId(), news.getnSource(),
					news.getnText(), news.getnImage() };
			qr.update(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}


	  public List<News> findBy8() throws SQLException { 
		  String sql = "SELECT * FROM news order by nTime DESC LIMIT 0,8"; 
		  return toNewList(qr.query(sql,new MapListHandler()));
	  
	  }
	 
	// 查询分类下的所有新闻
	public PageBean<News> findByCidNew(int pc, int ps, String cid)
			throws SQLException {
		try {
			PageBean<News> pb = new PageBean<News>();
			pb.setPc(pc);
			pb.setPs(ps);
			String sql = "select count(*) from news where nType = ?";
			Number num = (Number) qr.query(sql, new ScalarHandler(), cid);
			int tr = num.intValue();
			pb.setTr(tr);
			sql = "select * from news where nType=? order by nTime desc limit ?,?";
			List<News> beanList = toNewList(qr.query(sql, new MapListHandler(),
					cid, (pc - 1) * ps, ps));
			pb.setBeanList(beanList);
			return pb;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

	public List<News> toNewList(List<Map<String, Object>> map)
			throws SQLException {
		List<News> list = new ArrayList<News>();
		for (Map<String, Object> maplist : map) {
			News n = CommonUtils.toBean(maplist, News.class);
			Classify y = classifydao.findByid((String) maplist.get("nType"));
			Users u = findUsers((String) maplist.get("nEditor"));
			n.setnEditors(u);
			n.setnTypes(y);
			list.add(n);
		}
		return list;
	}

	// 查找所属发布者
	public Users findUsers(String uid) throws SQLException {
		String sql = "select * from user where uId=?";
		return qr.query(sql, new BeanHandler<Users>(Users.class), uid);
	}

/*	// 查找所属分类
	public Classify findClassify(String cid) throws SQLException {
		String sql = "select * from classify where cId=?";
		return qr.query(sql, new BeanHandler<Classify>(Classify.class), cid);
	}
*/
	// 删除新闻
	public void newDelete(String nid) throws SQLException {
		String sql = "delete from news where nid=?";
		qr.update(sql, nid);
	}

	// 编辑新闻时回显新闻即返回一个新闻
	public News findByNew(String nid) throws SQLException {
		String sql = "select * from news where nId=?";
		Map<String, Object> news = qr.query(sql, new MapHandler(), nid);

		Users u = findUsers((String) news.get("nEditor"));
		Classify c = classifydao.findByid((String) news.get("nType"));
		News n = CommonUtils.toBean(news, News.class);
		n.setnEditors(u);
		n.setnTypes(c);
		return n;
	}

	// 修改新闻
	public void editNew(News news) throws SQLException {
		String sql = "update news set nTheme=?,nTime=?,nType=?,nSource=?,nText=?,nImage=? where nId=?";
		Object[] params = { news.getnTheme(), news.getnTime(),
				news.getnTypes().getcId(), news.getnSource(), news.getnText(),
				news.getnImage(), news.getnId() };
		qr.update(sql, params);
	}

	// 删除新闻图片
	public Map<String, Object> newDeleteImage(String nid) {
		try {
			String sql = "select nImage from news where nId = ?";
			Map<String, Object> imageMap = qr.query(sql, new MapHandler(), nid);
			return imageMap;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	

}
