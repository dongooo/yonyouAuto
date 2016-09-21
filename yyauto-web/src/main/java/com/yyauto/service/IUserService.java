package com.yyauto.service;

import com.yyauto.model.User;

/**
 * description: 用户接口
 * author: dongooo
 * create: 2016-09-13 下午10:02
 * php: https://github.com/dongooo
 **/

public interface IUserService {

    public User findByUserName(String userName) throws Exception;

}
