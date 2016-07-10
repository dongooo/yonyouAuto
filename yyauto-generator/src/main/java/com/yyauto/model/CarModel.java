package com.yyauto.model;

public class CarModel {
    private Integer id;

    private String code;

    private String name;

    private String channel;

    private Integer isEnable;

    private String tecdocCategoryCode;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel == null ? null : channel.trim();
    }

    public Integer getIsEnable() {
        return isEnable;
    }

    public void setIsEnable(Integer isEnable) {
        this.isEnable = isEnable;
    }

    public String getTecdocCategoryCode() {
        return tecdocCategoryCode;
    }

    public void setTecdocCategoryCode(String tecdocCategoryCode) {
        this.tecdocCategoryCode = tecdocCategoryCode == null ? null : tecdocCategoryCode.trim();
    }
}