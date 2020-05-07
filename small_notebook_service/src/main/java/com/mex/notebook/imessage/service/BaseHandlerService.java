package com.mex.notebook.imessage.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.mex.notebook.IMServer.NettyServer;
import com.mex.notebook.admin.entity.User;
import com.mex.notebook.util.SpringUtil;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;

import io.netty.channel.socket.SocketChannel;
import io.netty.util.CharsetUtil;
import com.mex.notebook.admin.service.UserService;
import java.util.List;
import org.springframework.stereotype.Service;
 

/**
 * TODO
 *
 * @author xujinxin
 * @date 2020/4/28 5:03 PM
 */
@Service
public class BaseHandlerService extends ChannelInboundHandlerAdapter {
    private static UserService userService;
    
    static {
        userService = SpringUtil.getBean(UserService.class);
    }

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

            List  userList = userService.getList(null);

            object.put("content", userList);

            NettyServer.channelMap.put(object.getString("recv_id"),(SocketChannel) channelHandlerContext.channel());

        }

        SocketChannel channel= NettyServer.channelMap.get(object.getString("recv_id"));

        channel.writeAndFlush(Unpooled.copiedBuffer(object.toJSONString(), CharsetUtil.UTF_8));

        channelHandlerContext.flush();

    }

}
