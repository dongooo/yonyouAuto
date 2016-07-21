package com.yyauto.service;

import com.yyauto.model.CarModel;

/**
 * Created by dongooo on 16/7/8.
 */
public interface ICarModelService<T> {
    CarModel getCarModelByPrimaryKey(int primaryKey) throws Exception;
}
