package com.mex.notebook.IMServer.handler;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.mex.notebook.IMServer.NettyServer;
import com.mex.notebook.admin.entity.User;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.channel.socket.SocketChannel;
import io.netty.util.CharsetUtil;
import com.mex.notebook.admin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


public class BaseHandler extends ChannelInboundHandlerAdapter {

    @Override
    public void channelActive(ChannelHandlerContext ctx) throws Exception
    {

        System.out.println("客户端连接成功...");
    }

    @Override
    public void channelRead(ChannelHandlerContext channelHandlerContext, Object msg) throws Exception {
        try {
            ByteBuf buf = (ByteBuf)msg;

            //创建目标大小的数组
            byte[] barray = new byte[buf.readableBytes()];

            //把数据从bytebuf转移到byte[]
            buf.getBytes(0,barray);

            //将byte[]转成字符串用于打印
            String str=new String(barray);

            if (str.length()>0)
            {
//                NettyServer.map
                System.out.println(str);

                resultHandle(channelHandlerContext,str);
            }
            else
            {
                System.out.println("不能读啊");
            }
            buf.release();
        }finally {
            //buf.release();
        }
    }
     void resultHandle(ChannelHandlerContext channelHandlerContext, String msg){
        JSONObject object = JSON.parseObject(msg);

        if(object.getString("type").equals("verify_token")){


            object.put("type", "verify_success");

            HashMap<String, Object > a = new HashMap<String, Object>(){{
                put("id",1);
                put("username","xujinxin");
                put("realname","徐进鑫");
            }};
            HashMap<String, Object > b = new HashMap<String, Object>(){{
                put("id",2);
                put("username","JinVin");
                put("realname","晋国华");
            }};
            HashMap<String, Object > c = new HashMap<String, Object>(){{
                put("id",3);
                put("username","jv");
                put("realname","jv");
            }};

            List<Object> userList = new LinkedList<Object>(){{
                add(a);
                add(b);
                add(c);
            }};

            object.put("content", userList);

            NettyServer.channelMap.put(object.getString("recv_id"),(SocketChannel) channelHandlerContext.channel());

        }

        SocketChannel channel= NettyServer.channelMap.get(object.getString("recv_id"));
System.out.println(NettyServer.channelMap.size());
        channel.writeAndFlush(Unpooled.copiedBuffer(object.toJSONString(), CharsetUtil.UTF_8));

        channelHandlerContext.flush();

    }
}
