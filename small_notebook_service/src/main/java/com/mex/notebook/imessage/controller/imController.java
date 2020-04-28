package com.mex.notebook.imessage.controller;

import com.mex.notebook.common.Record;
import com.mex.notebook.imessage.service.NettyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * TODO
 *
 * @author xujinxin
 * @date 2020/4/28 4:49 PM
 */
@RestController
@RequestMapping("im")
public class imController {

    @Autowired
    private NettyService nettyService;

    @RequestMapping("start")
    public Record start(){
        nettyService.start(new Record());
        return Record.test();
    }
}
