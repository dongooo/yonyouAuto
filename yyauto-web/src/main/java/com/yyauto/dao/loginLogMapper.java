package com.yyauto.dao;

import com.yyauto.model.loginLog;

public interface loginLogMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(loginLog record);

    int insertSelective(loginLog record);

    loginLog selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(loginLog record);

    int updateByPrimaryKey(loginLog record);
}