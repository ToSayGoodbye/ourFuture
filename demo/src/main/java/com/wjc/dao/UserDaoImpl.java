package com.wjc.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.wjc.pojo.User;
public class UserDaoImpl extends SqlSessionDaoSupport {

	public List<User> queryUsers(Map map) {
		List<User> list =new ArrayList<User>();
		list = getSqlSession().selectList("queryUsers",map);
		return list;
	}

	public User selectByName(String name) {
		User user = new User();
		user = getSqlSession().selectOne("selectByName", name);
		return user;
	}

	public int queryUsersCount() {
		int count = getSqlSession().selectOne("queryUsersCount");
		return count;
	}
	
	public void addUser(User user) throws Exception {
		getSqlSession().insert("addUser",user);
	}
	
	public void updateUser(User user) throws Exception {
		getSqlSession().update("updateUser");
		throw new Exception("error!");
	}
	
	@Resource  
    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory){  
        super.setSqlSessionFactory(sqlSessionFactory);  
    }
	
	public void addPhoto(Map map) throws Exception {
		System.out.println("map"+map.get("comment"));
		getSqlSession().insert("addPhoto",map);
	}
}
