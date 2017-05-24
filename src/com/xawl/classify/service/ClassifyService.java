package com.xawl.classify.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.xawl.classify.dao.ClassifyDao;
import com.xawl.classify.domain.Classify;

public class ClassifyService {
	private ClassifyDao dao=new ClassifyDao();
	
	//查找一级分类
		public List<Classify> findByParent(){
			try {
				return dao.findByParent();
			} catch (SQLException e) {
					throw new RuntimeException(e);
			}
		}
		//返回一个类型类
		public Classify findByCid(String cid){
			try {
				return dao.findByid(cid);
			} catch (SQLException e) {
			throw new RuntimeException(e);
			}
		}
		//ajax查找一级菜单返回json  需要转换
		public String ajaxfindone(){
			try {
				return tojsonlist(dao.findByParent2());
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		
		
		
		//查找二级菜单
		public List<Classify> findBy2(String cid){
			try {
				return dao.findBy2(cid);
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		}
		//返回类型 并且打包成json
		public String ajaxfindByCids(String cid){
			try {
				return tojsonlist(dao.ajaxfindByCid(cid));
			} catch (SQLException e) {
					throw new RuntimeException(e);
			}
		}
		//转换json
		private String tojson(Map<String,Object>map){
			StringBuilder sb=new StringBuilder("{");
			sb.append("\"cId\"").append(":").append("\"").append(map.get("cId").toString()).append("\"");
			sb.append(",");
			sb.append("\"cName\"").append(":").append("\"").append(map.get("cName").toString()).append("\"");
			sb.append("}");
			return sb.toString();
		}
		private String tojsonlist(List<Map<String, Object>> list){
			StringBuilder sb=new StringBuilder("[");
			for(int i=0;i<list.size();i++){
				sb.append(tojson(list.get(i)));
				if(i<list.size()-1){
					sb.append(",");
				}
			
			}
			sb.append("]");
			return sb.toString();
		}
		//修改一级菜单
		public Boolean ajaxeditFirstMenu(String name,String desc,String cid){
			try {
			return	dao.ajaxeditFirstMenu(name, desc, cid);
			} catch (SQLException e) {
					throw new RuntimeException(e);
			}
		}
		//修改二级菜单
		public Boolean ajaxeditTwoMenu(String cName,String desc,String pid,String cid){
			try {
			return	dao.ajaxeditTwoMenu(cName,desc,pid,cid);
			} catch (SQLException e) {
					throw new RuntimeException(e);
			}
		}
		//ajax删除二级菜单
		public Boolean ajaxremoveMenu(String cid){
			try {
			return	dao.ajaxremoveMenu(cid);
			} catch (SQLException e) {
					throw new RuntimeException(e);
			}
		}
	//添加二级分类
		public void addTwoMenu(Classify c){
			try {
				dao.addTwoMenu(c);
			} catch (SQLException e) {
					throw new RuntimeException(e);
			}
		}
	public List<Classify> findAll(){
		try {
			return dao.findAll();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
