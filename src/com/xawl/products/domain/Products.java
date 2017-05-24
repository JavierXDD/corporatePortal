package com.xawl.products.domain;

import com.xawl.classify.domain.Classify;

public class Products {
	private String pId;		//产品id
	private Classify pTypes;	//产品类型
	private String pName;	//产品名称
	private String pImage;	//产品图片
	private String pText;	//产品介绍
	
	



	public Classify getpTypes() {
		return pTypes;
	}
	public void setpTypes(Classify pTypes) {
		this.pTypes = pTypes;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpImage() {
		return pImage;
	}
	public void setpImage(String pImage) {
		this.pImage = pImage;
	}
	public String getpText() {
		return pText;
	}
	public void setpText(String pText) {
		this.pText = pText;
	}
	@Override
	public String toString() {
		return "Products [pId=" + pId + ", pName=" + pName + ", pType=" + pTypes
				+ ", pImage=" + pImage + ", pText=" + pText + "]";
	}

	
}
