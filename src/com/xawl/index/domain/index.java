package com.xawl.index.domain;

public class index {
	private String iName;
	private String iValue;
	private String isImage;
	private String iId;
	private String iLocation;//1  左上 2右上  3左下 4右下
	
	public String getiLocation() {
		return iLocation;
	}
	public void setiLocation(String iLocation) {
		this.iLocation = iLocation;
	}
	public String getiId() {
		return iId;
	}
	public void setiId(String iId) {
		this.iId = iId;
	}
	public String getIsImage() {
		return isImage;
	}
	public void setIsImage(String isImage) {
		this.isImage = isImage;
	}
	public String getiValue() {
		return iValue;
	}
	public void setiValue(String iValue) {
		this.iValue = iValue;
	}
	public String getiName() {
		return iName;
	}
	public void setiName(String iName) {
		this.iName = iName;
	}
	public String getsImage(){
		int index=iValue.indexOf(".");
		String simage=iValue.substring(0,index);
		String ext=iValue.substring(index);
		return simage+"_s"+ext;
	}
}
