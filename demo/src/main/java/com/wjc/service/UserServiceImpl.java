package com.wjc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wjc.dao.IUserDao;
import com.wjc.pojo.User;

@Service
public class UserServiceImpl implements IUserService {
	
	@Autowired
    private IUserDao userDao;
	
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
		userDao.updateUser(user);
	}

}
