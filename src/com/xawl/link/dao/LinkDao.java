package com.xawl.link.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.itcast.jdbc.TxQueryRunner;

import com.xawl.link.domain.Link;
import com.xawl.news.domain.PageBean;

public class LinkDao {
	private QueryRunner qr = new TxQueryRunner();
	//查询所有链接
	public PageBean<Link> finkLink(int pc, int ps,String mark) {
		try {
			PageBean<Link> pb = new PageBean<Link>();
			pb.setPc(pc);
			pb.setPs(ps);
			String sql = "select count(*) from indexs where isImage = ?";
			Number num = (Number) qr.query(sql, new ScalarHandler(),2);
			int tr = num.intValue();
			pb.setTr(tr);
			sql = "select * from indexs where isImage = ? limit ?,?";
			List<Link> beanList = qr.query(sql, new BeanListHandler<Link>(Link.class), 2,(pc-1)*ps, ps);
			pb.setBeanList(beanList);
			return pb;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	//添加链接
	public void addLink(Link link) {
		try{
			String sql = "insert into indexs values(?,?,?,?,?)";
			Object[] params = {link.getiId(),link.getiName(),link.getiValue(),link.getIsImage(),link.getiLocation()};
			qr.update(sql, params);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	//查询单条链接
	public Link findLinkByiId(String iId) {
		try{
			String sql = "select * from indexs where iId = ?";
			return qr.query(sql, new BeanHandler<Link>(Link.class), iId);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	public void editLink(Link link) {
		try{
			String sql = "update indexs set iName=?,iValue=? where iId=?";
			Object[] params = {link.getiName(),link.getiValue(),link.getiId()};
			qr.update(sql, params);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	public void deletLink(String iId) {
		try{
			String sql = "delete from indexs where iId = ?";
			qr.update(sql,iId);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}

}
