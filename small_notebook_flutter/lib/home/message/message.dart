import 'package:flutter/material.dart';
import 'dart:io';
import 'package:web_socket_channel/io.dart';

class Message extends StatefulWidget {
  MessageState createState() => new MessageState();
}

class MessageState extends State<Message> {
  final String host = "ws://echo.websocket.org";
  final int port = 7888;
  IOWebSocketChannel channel;
  String _text = "";
  List _list = new List();
  @override
  void initState() {
    // //创建websocket连接
    // channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');

    // // 监听消息
    // channel.stream.listen((message) {
    //   print(message);
    //   setState(() {
    //     _list.add('[Received] ${message.toString()}');
    //   });
    // });
    // print('开始连接------');
    // Socket.connect('172.10.3.205', 7888).then((socket) {
    //   print('连接成功------');
    // });
  }

  void _sendMessage() {
    if (this._text != '') {
      channel.sink.add(this._text);
    }
  }

  List<Widget> _generatorList() {
    List<Widget> tmpList = _list.map((item) => ListItem(msg: item)).toList();
    List<Widget> prefix = [_generatorForm()];
    prefix.addAll(tmpList);
//    prefix.add(_messageInput());
    return prefix;
  }

  Widget _generatorForm() {
    return Column(
      children: <Widget>[
        TextField(onChanged: (text) => this._text = text),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              child: Text('Send'),
              onPressed: _sendMessage,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: _generatorList(),
    );
  }
}

class ListItem extends StatelessWidget {
  final String msg;
  ListItem({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(msg);
  }
}

//import 'package:flutter/material.dart';
//
//import 'dart:io';
//
//class Message extends StatefulWidget{
//  MessageState createState()=>new MessageState();
//}
//
//class MessageState extends State<Message>{
//
//  Widget build(BuildContext context){
//
//    return
//  }
//}
