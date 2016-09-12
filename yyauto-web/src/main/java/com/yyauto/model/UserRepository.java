package com.yyauto.model;

import com.scienjus.authorization.repository.UserModelRepository;
import com.yyauto.dao.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * description: 用户表扩展类,实现查询当前用户
 * author: dongooo
 * create: 2016-09-05 下午7:41
 * php: https://github.com/dongooo
 **/

public class UserRepository implements UserModelRepository{

    @Autowired
    UserMapper userMapper;

    @Override
    public Object getCurrentUser(String key) {
        User user = new User();
        user.setUid(key);
        User oneUser = userMapper.findByUser(user);
        return oneUser;
    }

}
