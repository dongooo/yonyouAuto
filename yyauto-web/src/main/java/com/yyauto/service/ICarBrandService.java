package com.yyauto.service;

import com.yyauto.model.CarBrand;

/**
 * description: 品牌接口
 * author: dongooo
 * create: 2016-07-19 下午10:35
 * php: https://github.com/dongooo
 **/

public interface ICarBrandService<T> {

    CarBrand getCarBrandByPrimaryKey(int primaryKey) throws Exception;

}
