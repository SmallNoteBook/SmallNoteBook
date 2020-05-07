package com.mex.notebook.common;

import java.util.HashMap;

/**
 * TODO
 *
 * @author xujinxin
 * @date 2020/4/28 4:50 PM
 */
public class Record extends HashMap {

    public static Record test(){
        Record record = new Record();
        record.put("code","test");
        record.put("msg","调用成功！");
        return record;
    }
}
