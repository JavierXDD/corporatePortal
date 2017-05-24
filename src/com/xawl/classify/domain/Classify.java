package com.xawl.classify.domain;

import java.util.List;

public class Classify {
		
	private String cId;  //菜单ID
	private String cName; //菜单名字
	private Classify parents; //菜单父类	
	
	private String cAddr;//菜单超链接
	private int isUse;//是否启用
	private String cDesc; //菜单说明文字
	private List<Classify> children; //菜单子类 菜单
	public String getcId() {
		return cId;
	}
	public void setcId(String cId) {
		this.cId = cId;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public Classify getParents() {
		return parents;
	}
	public void setParents(Classify parents) {
		this.parents = parents;
	}
	public String getcAddr() {
		return cAddr;
	}
	public void setcAddr(String cAddr) {
		this.cAddr = cAddr;
	}
	public int getIsUse() {
		return isUse;
	}
	public void setIsUse(int isUse) {
		this.isUse = isUse;
	}
	public String getcDesc() {
		return cDesc;
	}
	public void setcDesc(String cDesc) {
		this.cDesc = cDesc;
	}
	public List<Classify> getChildren() {
		return children;
	}
	public void setChildren(List<Classify> children) {
		this.children = children;
	}
	
}
