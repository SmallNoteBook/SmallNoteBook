import 'dart:io';
import 'dart:async';

/// 异步 Timer
import 'SocketProvider.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:notebook/util/localStorage/Storage.dart';

class ClientSocket {
  String host = '172.10.3.205';
  // String host = '0.0.0.0';
  // String host = '127.0.0.1';
  int port = 7888;

  int _id;

  dynamic localSocket; // 拿到socket实例，存储到provide中，便于其他页面使用socket的方法

  var response; // 接收socket返回回来的数据

  var localContext; // 存储传入进来的context，provide的方法在调用时需要传

  var token; // 获取本地token

  Timer timer;

  int commandTime = 15; // 向后台发送心跳的时间

  bool netWorkStatus = true; // 网络状态

  bool socketStatus = false; // socket状态

  void connect(context) async {
    await Socket.connect('172.10.3.205', 7888).then((socket) async {
      socketStatus = true;

      localSocket = socket;

      localContext = context;
      await Storage.getJson("userInfo").then((userInfo){
        this._id = userInfo["id"];
      });
      // 存储全局socket对象
      Provider.of<SocketProvider>(context, listen: false)
          .setSocket(localSocket);
      // 全局的socket设置为在线状态
//      Provider.of<SocketProvider>(context, listen: false).setOnlineSocket(true);


      // todo  现在将 token 换成 recv_id ，如果以后真的有了token ,再优化这里
//      Map arguments = {"type": "verify_token", "token": _id};
      Map arguments = {"type": "verify_token", "recv_id": _id};

      socket.write(json.encode(arguments));
      // socket监听
      socket.listen(dataHandler,
          // onError: errorHandler,
          onDone: doneHandler,
          cancelOnError: false);
      // gl_sock.close();
    }).catchError((e) {
      // print("socket无法连接: $e");
    });


  }

  // 接收socket返回报文
  dataHandler(data) async {
    print('-------Socket发送来的消息-------');
    var cnData = utf8.decode(data); // 将信息转为正常文字

    response = json.decode(cnData.toString());
    print('-------response-------');
print(response);
    // 判断返回的状态信息token验证是否成功，如果相等，变可以socket通信
    if (response['type'] == 'verify_success') {
//      Fluttertoast.showToast(msg: '欢迎登录~');
       //这个可以当作全局的联系人
      Provider.of<SocketProvider>(localContext, listen: false).setContact(response["content"]);
      //这个当作当前发送消息的人对应的消息列表
      Storage.set('messageList', response["content"]);
      // 给后台发送心跳
      heartbeatSocket();
      return;
    }

    // 判断 服务器返回的接收人id和发送人id如果不是同一个的话，开始进行socket信息的存储
    // recv_id:接收人、send_id：发送人
    // if (response['recv_id'] != int.parse(response['send_id'])) {

    if (response['recv_id'] != response['send_id']) {
      // 判断消息类型，存储到provide消息实体当中
      switch (response['content_type']) {
        case 'text':
          Provider.of<SocketProvider>(localContext, listen: false)
              .setRecords(response['Content'], 'text', false);
          break;
        case 'img':
          Provider.of<SocketProvider>(localContext, listen: false)
              .setRecords(response['Content'], 'img', false);
          break;
        case 'video':
          Provider.of<SocketProvider>(localContext, listen: false)
              .setRecords(response['Content'], 'video', false);
          break;
        case 'audio':
          Provider.of<SocketProvider>(localContext, listen: false).setRecords(
              response['Content'], 'audio', false,
              time_length: response['time_length']);
          break;
        default:
      }
    }else{

    }
  }

  void doneHandler() {
    socketStatus = false;
    reconnectSocket(); //调用重连socket方法
  }

  // 重新连接socket
  void reconnectSocket() {
    int count = 0;
    const period = const Duration(seconds: 1);
    // 定时器
    Timer.periodic(period, (timer) {
      // 每一次重连之前，都删除关掉上一个socket
      // gl_sock.close();
      localSocket = null;
      count++;
      if (count >= 3) {
        print('时间到了!!!开始从连socket');
        // 链接socket
        connect(localContext); // 重连
        count = 0; // 倒计时设置为0
        timer.cancel(); // 关闭倒计时
        timer = null; // 清空倒计时
//        Fluttertoast.cancel();    // 关闭弹框
      }
    });
  }

  // 心跳机，每15秒给后台发送一次，用来保持连接
  void heartbeatSocket() {
    print('-----心跳 -------');
    const duration = Duration(seconds: 1);

    var callback = (time) async {
      // 如果socket状态是断开的，就停止定时器
      if (!socketStatus) {
        time.cancel();
      }
      var _subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        // print('--------------------当前网络：$result------------------------');
        if (result != ConnectivityResult.mobile &&
            result != ConnectivityResult.wifi) {
          print('没有网络，停止定时器');
          netWorkStatus = false;
          time.cancel();
        } else {
          netWorkStatus = true;
        }
      });

      // token为空，关闭定时器
      if (token?.isEmpty==null) {
        time.cancel();
        return;
      }

      if (commandTime < 1) {
        print('-----------------发送心跳------------------');
        Map arguments = {
          "type": "heartbeat",
        };
        localSocket.write(json.encode(arguments));

        commandTime = 15;
      } else {
        commandTime--;
      }
    };

    timer = Timer.periodic(duration, callback);
  }
}
