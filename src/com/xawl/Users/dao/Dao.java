package com.xawl.Users.dao; 

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.itcast.jdbc.TxQueryRunner;

import com.xawl.Users.domain.Users;

/*
 * 数据库层
 * 
 */

public class Dao {
		private  QueryRunner qr=new TxQueryRunner();
		
		
	//对管理员的删除
		
	public void remove(){};
	
	//登陆查询
	public Users login(String username,String password) throws SQLException{
		String sql="select * from user where uId=? and uPassword=?";
		return qr.query(sql, new BeanHandler<Users>(Users.class),username,password);	
	}
		public  void add(Users user) throws SQLException{             //添加管理员
			
			String sql="insert into user values(?,?,?,?,?)";
			Object []param={user.getuId(),user.getIsSuper(),user.getuName(),user.getuPassword(),user.getuTime()};
			qr.update(sql, param);
		}
		
		public  void remove(String uid) throws SQLException{          //删除管理员 
			String sql="delete from user where uId=?";
				qr.update(sql,uid);
		}
		
		public List<Users> findAll() throws SQLException{         //查找所有的管理员
			String sql="select  * from user where isSuper=1";
			return qr.query(sql, new BeanListHandler<Users>(Users.class));
		}
	
		
		//以ID查询密码返回
		public Users findpassword(String uid) throws SQLException{
			String sql="select uPassword from user where uId=?";
			return qr.query(sql, new BeanHandler<Users>(Users.class),uid);
		}
	
	public void modify(String password,String uid) throws SQLException{
		String sql="update user set uPassword=? where uId=?";
		qr.update(sql,password,uid);
		
	}
	//ajax查询用户名是否已经存在
	public Boolean ajaxFindById(String uid) throws SQLException{
		String sql="select count(*) from user where uId=?";
		Number num=(Number)qr.query(sql, new ScalarHandler(),uid);
		return num.intValue()==0;
	}
	public Boolean ajaxFindByPassword(String uid,String password) throws SQLException{
		//检测旧密码是否正确
		String sql="select count(*) from user where uId=? and uPassword=?";
		Number num=(Number)qr.query(sql, new ScalarHandler(),uid,password);
		return num.intValue()==0;
	}

}
