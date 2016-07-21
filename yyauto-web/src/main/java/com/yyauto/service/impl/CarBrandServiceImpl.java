package com.yyauto.service.impl;

import com.yyauto.dao.CarBrandMapper;
import com.yyauto.model.CarBrand;
import com.yyauto.service.ICarBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * description: 品牌接口实现类
 * author: dongooo
 * create: 2016-07-19 下午10:36
 * php: https://github.com/dongooo
 **/

@Service
public class CarBrandServiceImpl implements ICarBrandService {
    @Autowired
    private CarBrandMapper carBrandMapper;

    /***
     * 根据主键ID查询车辆品牌
     *
     * @param primaryKey
     * @return
     * @throws Exception
     */
    public CarBrand getCarBrandByPrimaryKey(int primaryKey) throws Exception {

        String params = "";
        return carBrandMapper.selectByPrimaryKey(primaryKey);

    }
}
