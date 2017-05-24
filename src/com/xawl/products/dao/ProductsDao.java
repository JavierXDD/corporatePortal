package com.xawl.products.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.itcast.commons.CommonUtils;
import cn.itcast.jdbc.TxQueryRunner;

import com.xawl.classify.dao.ClassifyDao;
import com.xawl.classify.domain.Classify;
import com.xawl.news.domain.News;
import com.xawl.products.domain.PageBean;
import com.xawl.products.domain.Products;

public class ProductsDao {
	private QueryRunner qr = new TxQueryRunner();
	private ClassifyDao classifyDao = new ClassifyDao();
	// 查询分类下的所有产品
	public PageBean<Products> findByCidProducts(int pc, int ps, String cid)throws SQLException {
		try {
			PageBean<Products> pb = new PageBean<Products>();
			pb.setPc(pc);
			pb.setPs(ps);
			String sql = "select count(*) from products where pType = ?";
			Number num = (Number) qr.query(sql, new ScalarHandler(),cid);
			int tr = num.intValue();
			pb.setTr(tr);
			sql = "select * from products where pType=? limit ?,?";
			List<Map<String, Object>> list = qr.query(sql, new MapListHandler(),cid, (pc - 1) * ps, ps);
			List<Products> beanList = toNewList(list);
			pb.setBeanList(beanList);
			return pb;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public List<Products> toNewList(List<Map<String, Object>> list)
			throws SQLException {
		List<Products> lists = new ArrayList<Products>();
		for (Map<String, Object> maplist : list) {
			Products p = CommonUtils.toBean(maplist, Products.class);
			
			Classify y = classifyDao.findByid((String) maplist.get("pType"));
			p.setpTypes(y);
			lists.add(p);
		}
		return lists;
	}
	// 查找所属分类
	/*public Classify findClassify(String cid) throws SQLException {
		String sql = "select * from classify where cId=?";
		return qr.query(sql, new BeanHandler<Classify>(Classify.class), cid);
	}*/
	//添加新产品
	public void addProducts(Products productsBean) {
		try {
			String sql = "insert into products values(?,?,?,?,?)";
			Object[] params = {productsBean.getpId(),productsBean.getpName(),productsBean.getpTypes().getcId(),
					productsBean.getpImage(),productsBean.getpText()};
			qr.update(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	//删除产品
	public void productsDelete(String pid) {
		try {
			String sql = "delete from products where pId=?";
			qr.update(sql, pid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}		
	}
	//编辑时回显信息
	public Products findByProduct(String pid) throws SQLException {
		String sql = "select * from products where pId=?";
		Map<String, Object> Productslist = qr.query(sql, new MapHandler(), pid);
		Classify c = classifyDao.findByid((String) Productslist.get("pType"));
		Products n = CommonUtils.toBean(Productslist, Products.class);
		n.setpTypes(c);
		return n;
	}
	//编辑产品
	public void editProduct(Products p) throws SQLException{
		String sql = "update products set pName=?,pType=?,pImage=?,pText=? where pId=?";
		Object[]param={p.getpName(),p.getpTypes().getcId(),p.getpImage(),p.getpText(),p.getpId()};
		qr.update(sql,param);
	}
	public Map<String, Object> productsDeleteImage(String pid) {
		try {
			String sql = "select pImage from products where pId = ?";
			Map<String, Object> imageMap = qr.query(sql, new MapHandler(), pid);
			return imageMap;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
