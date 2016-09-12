package com.yyauto.model;

/**
 * description: token基类
 * author: dongooo
 * create: 2016-09-05 上午10:32
 * php: https://github.com/dongooo
 **/

public class BaseToken {

    //用户id
    private long userId;

    //随机生成的uuid
    private String token;

    public BaseToken(long userId, String token) {
        this.userId = userId;
        this.token = token;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

}
