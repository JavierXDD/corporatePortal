package com.xawl.news.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.xawl.classify.domain.Classify;
import com.xawl.news.dao.NewsDao;
import com.xawl.news.domain.News;
import com.xawl.news.domain.PageBean;

public class NewsService {

	private NewsDao newsDao = new NewsDao();
	//获取cName的cid
	public String findCidByCname(String cname) {
		return newsDao.findCidByCname(cname);
	}
	//获取(cName)新闻中心下的类型列表	
	public void addNews(News news) {
		newsDao.addNews(news);
	}
	
	public List<News> findBy8(){
		try {
			return newsDao.findBy8();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	//查询该类型下的所有新闻
	public PageBean<News> findByCidNew(int pc, int ps,String cid) {
		try {
			return newsDao.findByCidNew(pc, ps,cid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public void newDelete(String nid){
			try {
				newsDao.newDelete(nid);
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
	}
	
	//返回一个news 对象
	public News findByNew(String nid){
		try {
			return newsDao.findByNew(nid);
		} catch (SQLException e) {
				throw new RuntimeException(e);
		}
	}
	
	//编辑新闻
	public void editNew(News news){
		try {
			newsDao.editNew(news);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	//删除图片新闻
	public Map<String, Object>  newDeleteImage(String nid) {
		return newsDao.newDeleteImage(nid);
	}


}
