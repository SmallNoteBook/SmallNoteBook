import 'package:flutter/material.dart';
import 'package:notebook/util/localStorage/Storage.dart';
import 'package:provider/provider.dart';
import 'package:notebook/util/provider/SocketProvider.dart';

class Contact extends StatefulWidget {
  ContactState createState() => ContactState();
}

class ContactState extends State<Contact> {
  List _contactList = new List();
//  @override
//  void initState() {
//    super.initState();
////    _setUserData();
//    Storage.getJson("messageList").then((messageList) {
//      setState(() {
//        _messageList = messageList;
//      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return _listView();
  }

//  Widget _listView() {
//    return ListView.builder(
//        padding: const EdgeInsets.all(8),
//        itemCount: _messageList.length,
//        itemBuilder: (BuildContext context, int index) {
//          var item = _messageList[index];
//          return new ListTile(
//            leading: Icon(
//              Icons.account_box,
//              color: Colors.black,
//            ),
//            trailing: Icon(Icons.keyboard_arrow_right),
//            title: new Text(item['username']),
//            onTap: () async {
//              // 获取下一页返回过来数据的方法，打开新页面page3后，便会等着返回，返回此页时就能拿到page3返回的数据
//              var res = await Navigator.of(context)
//                  .pushNamed('/chat', arguments: item);
//              print('res--->$res');
//            },
//          );
//        });
//  }

  Widget _listView() {
    return Consumer<SocketProvider>(builder: (context, socketProvider, child) {
      List _contactList = socketProvider.contact;
      final _listTile = _contactList.map((item) {
        return ListTile(
          leading: Icon(
            Icons.account_box,
            color: Colors.black,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: new Text(item['username']),
          onTap: () {
             Navigator.of(context).pushNamed('/chat', arguments: item);
          },
        );
      });

      return ListView(
        children:
            ListTile.divideTiles(context: context, tiles: _listTile).toList(),
      );
    });
  }
}
