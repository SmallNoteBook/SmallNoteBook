package com.mex.notebook.admin.entity;

import java.io.Serializable;
import java.util.Date;


public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    //
    private Integer id;
    //
    private String username;
    //
    private String password;
    //
    private String realname;


    /**
     * get id, 
     */
    public Integer getId() {
        return id;
    }

    /**
     * set id, 设置:
     */
    public void setId(Integer id) {
        this.id = id;
    }


    /**
     * get username, 
     */
    public String getUsername() {
        return username;
    }

    /**
     * set username, 设置:
     */
    public void setUsername(String username) {
        this.username = username;
    }


    /**
     * get password, 
     */
    public String getPassword() {
        return password;
    }

    /**
     * set password, 设置:
     */
    public void setPassword(String password) {
        this.password = password;
    }


    /**
     * get realname, 
     */
    public String getRealname() {
        return realname;
    }

    /**
     * set realname, 设置:
     */
    public void setRealname(String realname) {
        this.realname = realname;
    }


    //初始化方法
    public void init() {
        //添加对数据库或实体对象的默认值处理

    }

}
