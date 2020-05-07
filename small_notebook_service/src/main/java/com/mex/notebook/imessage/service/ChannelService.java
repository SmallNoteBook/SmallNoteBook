package com.mex.notebook.imessage.service;

import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.socket.SocketChannel;
import org.springframework.stereotype.Service;


/**
 * TODO
 *
 * @author xujinxin
 * @date 2020/4/28 5:02 PM
 */
@Service
public class ChannelService extends ChannelInitializer<SocketChannel> {

    private BaseHandlerService baseHandlerService;

    @Override
    protected void initChannel(SocketChannel socketChannel) throws Exception {
        ChannelPipeline pipeline = socketChannel.pipeline();
        pipeline.addLast(baseHandlerService);
    }
}
