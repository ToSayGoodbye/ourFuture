package com.wjc.service;

import org.springframework.stereotype.Service;

import com.wjc.pojo.User;

@Service
public interface IUserService {
	public void addUser(User user) throws Exception;
}
