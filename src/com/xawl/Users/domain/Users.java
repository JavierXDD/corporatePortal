package com.xawl.Users.domain;

import java.io.Serializable;

/*
 * 管理员bean层
 */
public class Users implements Serializable{
	
	private String uId;  //登陆用户名
	private int isSuper;   //1 是管理员  2是超级管理员
	private String uName;  //用户姓名
	private String uPassword; //密码
	private String uTime; //创建日期
	
	public String getuTime() {
		return uTime;
	}
	public void setuTime(String uTime) {
		this.uTime = uTime;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getuPassword() {
		return uPassword;
	}
	public void setuPassword(String uPassword) {
		this.uPassword = uPassword;
	}
	
	public int getIsSuper() {
		return isSuper;
	}
	public void setIsSuper(int isSuper) {
		this.isSuper = isSuper;
	}

	
	 
	
	
	
}
