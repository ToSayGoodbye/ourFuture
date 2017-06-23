package com.wjc.pojo;

import org.springframework.stereotype.Component;

@Component
public class User {
	     private String uuid;
	     private String name;
	     private String score;
	     private String sex;
	     private String sport;
	     private String spouse;
	     private String description;
		public String getUuid() {
			return uuid;
		}
		public void setUuid(String uuid) {
			this.uuid = uuid;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getScore() {
			return score;
		}
		public void setScore(String score) {
			this.score = score;
		}
		public String getSex() {
			return sex;
		}
		public void setSex(String sex) {
			this.sex = sex;
		}
		public String getSport() {
			return sport;
		}
		public void setSport(String sport) {
			this.sport = sport;
		}
		public String getSpouse() {
			return spouse;
		}
		public void setSpouse(String spouse) {
			this.spouse = spouse;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
	     
	      
 }
