package com.xawl.about.dao;

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

import com.xawl.Users.domain.Users;
import com.xawl.about.domain.About;
import com.xawl.classify.domain.Classify;
import com.xawl.news.domain.News;
import com.xawl.news.domain.PageBean;
import com.xawl.products.domain.Products;

import cn.itcast.commons.CommonUtils;
import cn.itcast.jdbc.TxQueryRunner;

public class AboutDao {
	private QueryRunner qr = new TxQueryRunner();

	public PageBean<About> findAboutByCid(int pc, int ps, String cid) {
		try {
			PageBean<About> pb = new PageBean<About>();
			pb.setPc(pc);
			pb.setPs(ps);
			String sql = "select count(*) from about where aType = ?";
			Number num = (Number) qr.query(sql, new ScalarHandler(), cid);
			int tr = num.intValue();
			pb.setTr(tr);
			sql = "select * from about where aType=? limit ?,?";
			List<Map<String, Object>> list = qr.query(sql,
					new MapListHandler(), cid, (pc - 1) * ps, ps);
			List<About> beanList = toNewList(list);
			pb.setBeanList(beanList);
			return pb;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public List<About> toNewList(List<Map<String, Object>> list)
			throws SQLException {
		List<About> lists = new ArrayList<About>();
		for (Map<String, Object> maplist : list) {
			About a = CommonUtils.toBean(maplist, About.class);
			Classify y = findClassify((String) maplist.get("aType"));
			Users u = findUsers((String) maplist.get("aEditor"));
			a.setaTypes(y);
			a.setaEditors(u);
			lists.add(a);
		}
		return lists;
	}

	// 查找所属分类
	public Classify findClassify(String cid) throws SQLException {
		String sql = "select * from classify where cId=?";
		return qr.query(sql, new BeanHandler<Classify>(Classify.class), cid);
	}

	// 查找所属发布者
	public Users findUsers(String uid) throws SQLException {
		String sql = "select * from user where uId=?";
		return qr.query(sql, new BeanHandler<Users>(Users.class), uid);
	}

	public void addAbout(About about) {
		try {
			String sql = "insert into about values(?,?,?,?,?,?,?)";
			Object[] params = { about.getaId(), about.getaTypes().getcId(),
					about.getaTitle(), about.getaTime(),
					about.getaEditors().getuId(), about.getaText(),
					about.getaImage() };
			qr.update(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

	public void aboutDelete(String aid) throws SQLException {
		String sql = "delete from about where aid=?";
		qr.update(sql, aid);
	}

	public About findByAbout(String aid) {
		try {
			String sql = "select * from about where aId=?";
			Map<String, Object> about = qr.query(sql, new MapHandler(), aid);
			Users u = findUsers((String) about.get("aEditors"));
			Classify c = findClassify((String) about.get("aTypes"));
			About a = CommonUtils.toBean(about, About.class);
			a.setaEditors(u);
			a.setaTypes(c);
			return a;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void editNew(About a) {
		try {
			String sql = "update about set aTitle=?,aTime=?,aType=?,aText=?,aImage=? where aId=?";
			Object[] params = { a.getaTitle(), a.getaTime(),
					a.getaTypes().getcId(), a.getaText(), a.getaImage(),
					a.getaId() };
			qr.update(sql, params);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public Map<String, Object> aboutDeleteImage(String aid) {
		try {
			String sql = "select aImage from about where aId = ?";
			Map<String, Object> imageMap = qr.query(sql, new MapHandler(), aid);
			return imageMap;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public List<About> findAll() throws SQLException{
		String sql="SELECT * FROM about";
		return qr.query(sql, new BeanListHandler<About>(About.class));
	}

}
