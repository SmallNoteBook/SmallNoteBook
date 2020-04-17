package com.mex.notebook.IMServer;

public class MainServer {

    public static void main(String[] arg){
        NettyServer server = new NettyServer();
        server.setPort(7888);
        server.start();
    }
}

