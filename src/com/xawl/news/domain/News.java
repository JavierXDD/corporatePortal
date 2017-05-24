package com.xawl.news.domain;

import com.xawl.Users.domain.Users;
import com.xawl.classify.domain.Classify;

public class News {
	private String nId;		//新闻编号	
	private String nTheme;	//新闻主题
	private String nTime;	//创建时间
	private Users nEditors;	//发布者
	private Classify nTypes;	//新闻类型
	private String nSource;	//新闻来源
	private String nText;	//新闻内容
	private String nImage;	//新闻图片
	
	
	public News() {
		super();
		// TODO Auto-generated constructor stub
	}


	public String getnTheme() {
		return nTheme;
	}


	public void setnTheme(String nTheme) {
		this.nTheme = nTheme;
	}


	public String getnTime() {
		return nTime;
	}


	public void setnTime(String nTime) {
		this.nTime = nTime;
	}


	
	
	public String getnId() {
		return nId;
	}


	public void setnId(String nId) {
		this.nId = nId;
	}


	public Users getnEditors() {
		return nEditors;
	}


	public void setnEditors(Users nEditors) {
		this.nEditors = nEditors;
	}


	public Classify getnTypes() {
		return nTypes;
	}


	public void setnTypes(Classify nTypes) {
		this.nTypes = nTypes;
	}


	public String getnSource() {
		return nSource;
	}


	public void setnSource(String nSource) {
		this.nSource = nSource;
	}


	public String getnText() {
		return nText;
	}


	public void setnText(String nText) {
		this.nText = nText;
	}


	public String getnImage() {
		return nImage;
	}


	public void setnImage(String nImage) {
		this.nImage = nImage;
	}


	@Override
	public String toString() {
		return "News [nId=" + nId + ", nTheme=" + nTheme + ", nTime=" + nTime
				+ ", nEditors=" + nEditors + ", nTypes=" + nTypes
				+ ", nSource=" + nSource + ", nText=" + nText + ", nImage="
				+ nImage + "]";
	}

	

	
}
