package com.xawl.link.domain;

public class Link {
	private String iId;
	private String iName;
	private String iValue;
	private String isImage;
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
	public String getiName() {
		return iName;
	}
	public void setiName(String iName) {
		this.iName = iName;
	}
	public String getiValue() {
		return iValue;
	}
	public void setiValue(String iValue) {
		this.iValue = iValue;
	}
	public String getIsImage() {
		return isImage;
	}
	public void setIsImage(String isImage) {
		this.isImage = isImage;
	}
	@Override
	public String toString() {
		return "Link [iId=" + iId + ", iName=" + iName + ", iValue=" + iValue
				+ ", isImage=" + isImage + ", iLocation=" + iLocation + "]";
	}

	
	
}
