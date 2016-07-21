package com.yyauto.model;

import java.util.Date;

public class loginLog {
    private Integer id;

    private String uid;

    private Date enterTime;

    private String enterIp;

    private Boolean status;

    private String browser;

    private String screenResolution;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid == null ? null : uid.trim();
    }

    public Date getEnterTime() {
        return enterTime;
    }

    public void setEnterTime(Date enterTime) {
        this.enterTime = enterTime;
    }

    public String getEnterIp() {
        return enterIp;
    }

    public void setEnterIp(String enterIp) {
        this.enterIp = enterIp == null ? null : enterIp.trim();
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getBrowser() {
        return browser;
    }

    public void setBrowser(String browser) {
        this.browser = browser == null ? null : browser.trim();
    }

    public String getScreenResolution() {
        return screenResolution;
    }

    public void setScreenResolution(String screenResolution) {
        this.screenResolution = screenResolution == null ? null : screenResolution.trim();
    }
}