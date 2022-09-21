package com.tyust.matlab.service;

import com.tyust.matlab.entity.User;

public interface UserService {

    User queryUser(User user);

    int createUser(User user);
}
