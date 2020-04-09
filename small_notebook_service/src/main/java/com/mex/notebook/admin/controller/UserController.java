package com.mex.notebook.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mex.notebook.admin.entity.User;
import com.mex.notebook.admin.service.UserService;


@RestController
@RequestMapping("admin/user")
public class UserController {

    /**
     * 获取用户列表
     * @param params
     * @return
     */
    @RequestMapping("/list")
    public Map<String,Object> list(@RequestParam Map<String, Object> params){
        Map<String,Object> result = new HashMap<>();

        List<User> userList = userService.getList(null);
        result.put("userList",userList);
        return result;
    }

    @Autowired
    private UserService userService;

}
