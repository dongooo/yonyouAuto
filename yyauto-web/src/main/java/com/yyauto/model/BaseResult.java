package com.yyauto.model;

/**
 * description: 返回结果基类
 * author: dongooo
 * create: 2016-09-05 上午10:56
 * php: https://github.com/dongooo
 **/

public class BaseResult {

    /**
     * 返回码
     */
    private int code;

    /**
     * 返回结果描述
     */
    private String message;

    /**
     * 返回内容
     */
    private Object content;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getContent() {
        return content;
    }

    public void setContent(Object content) {
        this.content = content;
    }

    public BaseResult(BaseResultStatus status) {
        this.code = status.getCode();
        this.message = status.getMessage();
        this.content = "";
    }

    public BaseResult(BaseResultStatus status, Object content) {
        this.code = status.getCode();
        this.message = status.getMessage();
        this.content = content;
    }

    public static BaseResult ok(Object content) {
        return new BaseResult(BaseResultStatus.SUCCESS, content);
    }

    public static BaseResult ok() {
        return new BaseResult(BaseResultStatus.SUCCESS);
    }


}
