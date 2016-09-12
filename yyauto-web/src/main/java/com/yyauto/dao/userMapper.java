package com.yyauto.dao;

import com.yyauto.model.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    //根据用户名查询用户信息
    User findByUserName(String userName);

    //根据USERMAP查询用户
    User findByUser(User user);
}