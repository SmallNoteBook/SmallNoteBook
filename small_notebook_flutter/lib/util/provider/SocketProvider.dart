import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notebook/util/provider/initSocket.dart';
//import 'package:project/plugins/PublicStorage.dart';

class SocketProvider with ChangeNotifier {
  Socket socket; // 存储socket实例
  String netWorkstate = 'none'; // 网络状态
//  List<ChatRecord> _records = List<ChatRecord>();
  List contact = List();
  Map<int, List<ChatRecord>> records = Map();

// 存储socket实例
  setSocket(val) {
    this.socket = val;
    notifyListeners();
  }

// 存储发送来的消息
// 私聊消息，消息类型, 是不是我发送的，语音时间长度, 是否需要显示成网络信息， 是不是历史记录存储
  setRecords(id, message, String type, bool newIsMe,
      {String time_length, history: false}) {
    if (records.containsKey(id)) {
      records[id] = records[id]
        ..insert(
            0,
            ChatRecord(
                message: message,
                type: type,
                newIsMe: newIsMe,
                time_length: time_length));
    } else {
      print("&&&&&&&&&&&&&");
      records.addAll({
        id: [
          ChatRecord(
              message: message,
              type: type,
              newIsMe: newIsMe,
              time_length: time_length)
        ]
      });
print("&&&&&&&&&&&&&${records}");
    }

    notifyListeners();
  }

  //更新联系人
  setContact(List list) {
    this.contact = list;
  }

// 清空消息页面
  clearRecords() {
//    records = [];
  }

// 设置当前网络状态
  setnetWorkState(val, context) async {
    var socket = new ClientSocket(); // 在这里实例化socket，这里是整个APP的socket调用最开始的地方

//    var token = await PublicStorage.getHistoryList('token'); // 获取本地token

// 只有当之前没有网络的时候，从新有了网络后并且token存在的情况下才会从新触发socket通信
// 默认的时候是none 所以初始化第一次打开的时候是可以触发的
    print('-----------------------------链接socket前-------------------------');
    if (netWorkstate == 'none' && (val == '4G' || val == 'Wifi')) {
      print('-----------------------------链接socket-------------------------');
      socket.connect(context);
    }
// 设置网络状态
    netWorkstate = val;
    notifyListeners();
  }

// 获取当前网络状态
  getnetWorkState() {
    return netWorkstate;
  }
}

// 私聊发送消息内容数据
class ChatRecord {
  var message; // 消息内容
  String time_length; // 语音时长
  String type; // 消息类型
  bool newIsMe; // 是不是我发送的
  ChatRecord({this.message, this.type, this.newIsMe, this.time_length});
}
