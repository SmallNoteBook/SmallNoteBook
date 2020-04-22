package com.mex.notebook.IMServer.handler;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.channel.SimpleChannelInboundHandler;

public class BaseHandler extends ChannelInboundHandlerAdapter {

    @Override
    public void channelRead(ChannelHandlerContext channelHandlerContext, Object msg) throws Exception {
        try {
            ByteBuf buf = (ByteBuf)msg;
            //创建目标大小的数组
            System.out.println(buf);
            byte[] barray = new byte[buf.readableBytes()];
            System.out.println(barray);
            //把数据从bytebuf转移到byte[]
            buf.getBytes(0,barray);
            //将byte[]转成字符串用于打印
            String str=new String(barray);
            if (str.length()>0)
            {
                System.out.println(str);
                System.out.flush();
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
}
