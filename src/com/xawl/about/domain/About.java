package com.xawl.about.domain;

import com.xawl.Users.domain.Users;
import com.xawl.classify.domain.Classify;

public class About {
	private String aId;
	private Classify aTypes;
	private String aTitle;
	private String aTime;
	private Users aEditors;
	private String aText;
	private String aImage;
	

	public String getaId() {
		return aId;
	}
	public void setaId(String aId) {
		this.aId = aId;
	}
	public String getaTitle() {
		return aTitle;
	}
	public void setaTitle(String aTitle) {
		this.aTitle = aTitle;
	}
	public String getaTime() {
		return aTime;
	}
	public void setaTime(String aTime) {
		this.aTime = aTime;
	}

	public String getaText() {
		return aText;
	}
	public void setaText(String aText) {
		this.aText = aText;
	}
	public String getaImage() {
		return aImage;
	}
	public void setaImage(String aImage) {
		this.aImage = aImage;
	}
	public Classify getaTypes() {
		return aTypes;
	}
	public void setaTypes(Classify aTypes) {
		this.aTypes = aTypes;
	}
	public Users getaEditors() {
		return aEditors;
	}
	public void setaEditors(Users aEditors) {
		this.aEditors = aEditors;
	}
	@Override
	public String toString() {
		return "About [aId=" + aId + ", aTypes=" + aTypes + ", aTitle="
				+ aTitle + ", aTime=" + aTime + ", aEditors=" + aEditors
				+ ", aText=" + aText + ", aImage=" + aImage + "]";
	}

	
	
}
