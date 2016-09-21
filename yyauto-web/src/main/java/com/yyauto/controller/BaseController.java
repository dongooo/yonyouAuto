package com.yyauto.controller;

import com.scienjus.authorization.annotation.Authorization;
import com.yyauto.service.ICarBrandService;
import com.yyauto.service.ICarModelService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by dongooo on 16/7/8.
 */
@Controller
@RequestMapping("base")
public class BaseController {

    @Resource
    private ICarModelService iCarModelService;
    @RequestMapping(value = "/car/model/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> test(@PathVariable int id,HttpServletRequest req) throws Exception{
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("list",iCarModelService.getCarModelByPrimaryKey(id));
        map.put("name","王晓二");
        map.put("age","255");
        return map;
    }


    @Resource
    private ICarBrandService iCarBrandService;

    @RequestMapping(value = "carBrand/{id}",method = RequestMethod.GET)
    @Authorization
    public @ResponseBody Map<String,Object> getCarBrandById(@PathVariable int id) throws Exception{
        Map<String,Object> map = new HashMap<String, Object>();

        map.put("list",iCarBrandService.getCarBrandByPrimaryKey(id));

        map.put("success",true);
        map.put("message","OK");
        return map;
    }

}
