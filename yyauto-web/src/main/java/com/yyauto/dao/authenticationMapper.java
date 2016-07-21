package com.yyauto.dao;

import com.yyauto.model.authentication;

public interface authenticationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(authentication record);

    int insertSelective(authentication record);

    authentication selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(authentication record);

    int updateByPrimaryKey(authentication record);
}