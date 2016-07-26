package com.yyauto.dao;

import com.yyauto.model.Authentication;

public interface AuthenticationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Authentication record);

    int insertSelective(Authentication record);

    Authentication selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Authentication record);

    int updateByPrimaryKey(Authentication record);
}