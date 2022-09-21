package com.tyust.matlab.mapper;

import com.tyust.matlab.entity.User;

public interface UserMapper {

    User selectUser(User user);

    int insertUser(User user);
}
