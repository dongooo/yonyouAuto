package com.yyauto.model;

/**
 * description: 返回状态基类
 * author: dongooo
 * create: 2016-09-05 上午11:00
 * php: https://github.com/dongooo
 **/

public enum BaseResultStatus {

    SUCCESS(100, "成功");

    /**
     * 返回码
     */
    private int code;

    /**
     * 返回结果描述
     */
    private String message;

    BaseResultStatus(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

}
