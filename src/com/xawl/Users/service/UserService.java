package com.xawl.Users.service;

import java.sql.SQLException;
import java.util.List;

import com.xawl.Users.dao.Dao;
import com.xawl.Users.domain.Users;

/*
 * 
 */
public class UserService {
	private Dao dao=new Dao();
	
	
	public Users login(String username,String password)
	{
		try {
			return dao.login(username, password);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public void add(Users user){
		try {
			dao.add(user);
		} catch (SQLException e) {
		throw new RuntimeException(e);
		}
	}
public List<Users> findAll(){
	try {
		return dao.findAll();
	} catch (SQLException e) {
			throw new RuntimeException(e);
	}
}

public void remove(String uid){
	try {
		dao.remove(uid);
	} catch (SQLException e) {
		throw new RuntimeException(e);
	}
}
public String findpassword(String uid){
	try {
		Users user=dao.findpassword(uid);        //返回密码
		return user.getuPassword();
	} catch (SQLException e) {
		throw new RuntimeException(e);
	}
}
public  void modify(String password,String uid){
	try {
		dao.modify(password, uid);
	} catch (SQLException e) {
		throw new RuntimeException(e);
	}
}

public Boolean ajaxFindById(String uid)  //ajax判断 UID是否存在
{
	try {
		return dao.ajaxFindById(uid);
	} catch (SQLException e) {
	throw new RuntimeException(e);
	}
}
public Boolean ajaxFindByPassword(String uid,String password)  //ajax判断 UID是否存在
{
	try {
		return dao.ajaxFindByPassword(uid,password);
	} catch (SQLException e) {
	throw new RuntimeException(e);
	}
}
}
