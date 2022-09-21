package com.tyust.matlab.service.impl;

import com.tyust.matlab.entity.User;
import com.tyust.matlab.mapper.UserMapper;
import com.tyust.matlab.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public User queryUser(User user) {
        return userMapper.selectUser(user);
    }

    @Override
    public int createUser(User user) {
        return userMapper.insertUser(user);
    }
}
