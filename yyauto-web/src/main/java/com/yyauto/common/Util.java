package com.yyauto.common;

import java.util.Calendar;
import java.util.Date;

/**
 * description: 工具类
 * author: dongooo
 * create: 2016-08-08 上午11:09
 * php: https://github.com/dongooo
 **/

public final class Util {

    public static Date getExpiryDate(int minutes){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.MINUTE,minutes);
        return  calendar.getTime();
    }

}
