package com.yyauto.service.impl;

import com.yyauto.dao.UserMapper;
import com.yyauto.model.User;
import com.yyauto.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * description: 用户接口实现类
 * author: dongooo
 * create: 2016-09-13 下午10:05
 * php: https://github.com/dongooo
 **/

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserMapper userMapper;

    public User findByUserName(String userName){
        return userMapper.findByUserName(userName);
    }

}
