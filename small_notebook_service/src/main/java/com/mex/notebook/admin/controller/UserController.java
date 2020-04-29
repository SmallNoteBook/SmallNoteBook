package com.mex.notebook.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mex.notebook.IMServer.NettyServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mex.notebook.admin.entity.User;
import com.mex.notebook.admin.entity.Result;
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

    @RequestMapping("/login")
    public Map<String ,Object> login(@RequestParam Map<String,Object> param){
        Map <String,Object> result = new HashMap<>();
        List <User> list  = userService.getUser(param);
        if(list.size()>0){
            result.put("data",list.get(0));
            result.put("code",200);
            result.put("message","登录成功");
        }else {
            result.put("data",null);
            result.put("code",201);
            result.put("message","账号密码错误");
        }
        return  result;
    }

    @RequestMapping("/nettyStart")
    public void nettyStart(@RequestParam Map<String,Object> param){
        NettyServer server = new NettyServer();
        server.setPort(7888);
        server.start();
    }

//    public static  void threadSocket(){
//        Thread t =  new Thread(){
//            @Override
//           public void run (){
//                NettyServer server = new NettyServer();
//                server.setPort(7888);
//                server.start();
//            }
//        };
//        t.start();
//    }

    @Autowired
    private UserService userService;

}

