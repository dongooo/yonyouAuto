package com.yyauto.service.impl;

import com.yyauto.dao.CarModelMapper;
import com.yyauto.model.CarModel;
import com.yyauto.service.ICarModelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by dongooo on 16/7/8.
 */
@Service
public class CarModelServiceImpl implements ICarModelService {

    @Autowired
    private CarModelMapper carModelMapper;

    /***
     * 根据主键ID查询车辆信息
     * @param primaryKey
     * @return
     * @throws Exception
     */
    public CarModel getCarModelByPrimaryKey(int primaryKey) throws Exception{

        String params = "";
        return carModelMapper.selectByPrimaryKey(primaryKey);
    }
}
