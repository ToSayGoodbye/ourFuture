package com.wjc.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.wjc.pojo.Photo;
import com.wjc.pojo.User;
@Repository
public interface IUserDao {
	
	//查询所有用户
	public List<User> queryUsers(Map map);
	
	//查询所有图片
	public List<Photo> queryPhotos(Map map);
	
	//查询图片个数
	public int queryPhotosCount(Map<String, Object> pageMap);
	
	//查询用户个数
	public int queryUsersCount();
	
	//根据name查询用户
	public User selectByName(String name);
	
	//添加用户
	public void addUser(User user) throws Exception;
	
	//修改用户
	public void updateUser(User user) throws Exception;

	//添加图片信息
	void addPhoto(Map map) throws Exception;
	
	//删除图片
	void deletePhoto(Map map) throws Exception;
	
	//查询设置为level为1的个数
	public int countLevel() throws Exception;
}
