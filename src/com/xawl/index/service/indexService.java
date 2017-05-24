package com.xawl.index.service;

import java.awt.print.Book;
import java.sql.SQLException;
import java.util.List;

import com.xawl.index.dao.indexDao;
import com.xawl.index.domain.index;

public class indexService {
	private indexDao indexdao=new indexDao();
	
	//重命名
	public Boolean ajaxeditImage(String iName,String iId) 
	{
		try {
			return indexdao.ajaxeditImage(iName, iId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	//查找非图片
	public List<index> findByInfo(){
		try {
			return indexdao.findByInfo();
		} catch (SQLException e) {
		throw new RuntimeException(e);
		}
	}
	//ajax删除字段
	public Boolean ajaxremoveInfo(String iId){
		try {
			return indexdao.ajaxremoveInfo(iId);
		} catch (SQLException e) {
				throw new RuntimeException(e);
		}
	}
	//编辑
	public Boolean editInfo(index i){
		try {
			return indexdao.editInfo(i);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e);
		}
	}
	//添加
	public Boolean addInfo(index x){
		try {
			return indexdao.addInfo(x);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e);
		}
	}
	//查询
	public List<index>findByMaxImage(String image){
		try {
			return indexdao.findByMaxImage(image);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e);
		}
	}
	//查询
	public index findByiId(String iid){
		try {
			return indexdao.findByiId(iid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	//查询小图
	public index findisLocation(String ilocation){
		try {
			return indexdao.findisLocation(ilocation);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	//编辑小图
	public void	 editMinImage(String iLocation,String iValue,String iName,String iId) {
		try {
			indexdao.editMinImage(iLocation,iValue,iName,iId);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
