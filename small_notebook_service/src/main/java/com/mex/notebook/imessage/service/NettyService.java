package com.mex.notebook.imessage.service;

import com.mex.notebook.common.Record;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * TODO
 *
 * @author xujinxin
 * @date 2020/4/28 4:56 PM
 */
@Service
public class NettyService {

    static int DefaultPort = 8777;

    @Autowired
    private ChannelService channelService;

    @Async
    public void start(Record record){
        EventLoopGroup boss = new NioEventLoopGroup();
        EventLoopGroup work = new NioEventLoopGroup();

        try {
            ServerBootstrap bootstrap = new ServerBootstrap();
            bootstrap.group(boss,work);
            bootstrap.channel(NioServerSocketChannel.class);
            bootstrap.option(ChannelOption.SO_BACKLOG,1024);// 连接数
            bootstrap.option(ChannelOption.TCP_NODELAY,true); // 消息不延迟立刻发送
            bootstrap.option(ChannelOption.SO_KEEPALIVE,true); // 长连接
            bootstrap.childHandler(channelService); // 设置消息处理器

            ChannelFuture channelFuture = bootstrap.bind(DefaultPort).sync();
            if(channelFuture.isSuccess()){
                System.out.println("服务启动成功！，端口号："+DefaultPort);
            }
            channelFuture.channel().closeFuture().sync();

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            boss.shutdownGracefully();
            work.shutdownGracefully();
        }
    }

}
