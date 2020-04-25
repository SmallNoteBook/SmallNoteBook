import 'package:flutter/material.dart';
import 'package:notebook/util/localStorage/Storage.dart';

class Message extends StatefulWidget {
  MessageState createState() => MessageState();
}

class MessageState extends State<Message> {
   List _messageList = new List();

  @override
  void initState() {
    super.initState();
//    _setUserData();
    Storage.getJson("messageList").then((messageList) {
      setState(() {
        _messageList = messageList;
        print("messageList2");
        print(messageList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _listView();
  }

  Widget _listView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _messageList.length,
        itemBuilder: (BuildContext context, int index) {
          var item = _messageList[index];
          return new ListTile(
          leading: Icon(
            Icons.account_box,
            color: Colors.black,
          ),
            trailing: Icon(Icons.keyboard_arrow_right),
            title: new Text(
              item['username']
            ),
            onTap: () async {
              // 获取下一页返回过来数据的方法，打开新页面page3后，便会等着返回，返回此页时就能拿到page3返回的数据
              var res = await Navigator.of(context).pushNamed('/chat',arguments: item);
              print('res--->$res');
            },
          );
        });
  }
}
