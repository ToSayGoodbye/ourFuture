package com.wjc.pojo;

import org.springframework.stereotype.Component;

@Component
public class Photo {
	private String id;
	private String picture_path;
	private String picture_information;
	private String state;
	private String picture_type;
	private String picture_name;
	private String picture_state;
	private String state_name;
	private String identity_card;
	private String if_original;
	private String putin_date;
	private String associate_id;
	private String picture_blob;
	private String COMMENT;
	private String LEVEL;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPicture_path() {
		return picture_path;
	}
	public void setPicture_path(String picture_path) {
		this.picture_path = picture_path;
	}
	public String getPicture_information() {
		return picture_information;
	}
	public void setPicture_information(String picture_information) {
		this.picture_information = picture_information;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPicture_type() {
		return picture_type;
	}
	public void setPicture_type(String picture_type) {
		this.picture_type = picture_type;
	}
	public String getPicture_name() {
		return picture_name;
	}
	public void setPicture_name(String picture_name) {
		this.picture_name = picture_name;
	}
	public String getPicture_state() {
		return picture_state;
	}
	public void setPicture_state(String picture_state) {
		this.picture_state = picture_state;
	}
	public String getState_name() {
		return state_name;
	}
	public void setState_name(String state_name) {
		this.state_name = state_name;
	}
	public String getIdentity_card() {
		return identity_card;
	}
	public void setIdentity_card(String identity_card) {
		this.identity_card = identity_card;
	}
	public String getIf_original() {
		return if_original;
	}
	public void setIf_original(String if_original) {
		this.if_original = if_original;
	}
	public String getPutin_date() {
		return putin_date;
	}
	public void setPutin_date(String putin_date) {
		this.putin_date = putin_date;
	}
	public String getAssociate_id() {
		return associate_id;
	}
	public void setAssociate_id(String associate_id) {
		this.associate_id = associate_id;
	}
	public String getPicture_blob() {
		return picture_blob;
	}
	public void setPicture_blob(String picture_blob) {
		this.picture_blob = picture_blob;
	}
	public String getCOMMENT() {
		return COMMENT;
	}
	public void setCOMMENT(String cOMMENT) {
		COMMENT = cOMMENT;
	}
	public String getLEVEL() {
		return LEVEL;
	}
	public void setLEVEL(String lEVEL) {
		LEVEL = lEVEL;
	}
	
}
