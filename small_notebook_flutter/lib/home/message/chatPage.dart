import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notebook/util/provider/SocketProvider.dart';
import 'package:provider/provider.dart';
import 'package:notebook/components/ScaffoldLayout.dart';
import 'package:notebook/util/localStorage/Storage.dart';

/// 聊天界面
class ChatPage extends StatefulWidget {
  final arguments;
  ChatPage({Key key, this.arguments}) : super(key: key) {
    print(this.arguments);
  }

  @override
  ChatPageState createState() {
    return ChatPageState(this.arguments);
  }
}

class ChatPageState extends State<ChatPage> {
  // 这里注意一下这个arguments，是我们用来接收上个页面传来的用户名以及头像
  final arguments;
  ChatPageState(this.arguments);
  var userInfo;
  bool soundRecording = false; // 是否显示语音按钮
  double _height = 0; // 控制操作栏的高度
  var localSocket;
  var localImage, localVideo; // 本地图片和视频
  var audioPath; // 语音路径
  var duration = Duration(milliseconds: 200);
  Map<String,dynamic> _lastMessage = new Map();
  // 输入框
  TextEditingController _textEditingController;
  // 滚动控制器
  ScrollController _scrollController;
  // 语音播放控制器
//  FlutterPluginRecord recordPlugin;

  // ClientSocket socket;

  @override
  void initState() {
    super.initState();
//    _setUserData();

    Storage.getJson("userInfo").then((userInfo) {
      this.userInfo = userInfo;
    });

    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
//    recordPlugin =  FlutterPluginRecord();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
//    recordPlugin.dispose();
    super.dispose();
  }

//  // 获取用户数据（这个方法读者可以酌情处理需不需要，可以全局搜索一下userInfo这个变量的用到的地方再决定）
//  _setUserData(){
//    api.getData(context, 'userInfo').then((val){
//      if(val == null){
//        return;
//      }
//      var response = json.decode(val.toString());
//      print('--------------获取服务器用户数据----------------');
//      print(response);
//      setState(() {
//        userInfo = response;
//      });
//      PublicStorage.setHistoryList('UserInfo', response);
//    });
//  }

  // 发送消息
  void _sendMsg(String msg, SocketProvider socketProvider) {
    Map contentArguments = {
      'type': 'private_chat',
      'content_type': 'text',
      'Content': msg,
      // 'recv_id': arguments['recv_id']
      'recv_id': arguments["id"],
      'send_id': userInfo['id']
    };
    // 存储文字消息
    Provider.of<SocketProvider>(context, listen: false)
        .setRecords(arguments["id"], msg, 'text', true);

    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
    // socket发送消息
    socketProvider.socket.write(json.encode(contentArguments));
  }

  startRecord() {
    print("111开始录制");
  }

  stopRecord(String path, double audioTimeLength) async {
    print("结束束录制");
    print("音频文件位置" + path);
    print("音频录制时长" + audioTimeLength.toString());
    setState(() {
      this.audioPath = path;
    });

//    api.postData(context, 'uploadFile', formData: await formData1(path)).then((data){
//      var audiourl = json.decode(data.toString())['file_path'];
//      Map contentArguments = {
//        'type':'private_chat',
//        'content_type':'audio',
//        'Content':audiourl,
//        'time_length':audioTimeLength.toString(),
//        'recv_id':arguments['recv_id']
//      };
//      print(contentArguments);
//      // socket发送消息
//      gl_socket.write(json.encode(contentArguments));
//      // 存储语音文件
//      Provide.value<SocketProvider>(context).setRecords(path,'audio', true, time_length:audioTimeLength.toString());
//
//    });
  }

  Widget _messages() {
    return Consumer<SocketProvider>(
      builder: (context, socketProvider, child) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Divider(
                height: 0.5,
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    child: EasyRefresh.custom(
                      scrollController: _scrollController,
                      reverse: true,
                      footer: CustomFooter(
                          enableInfiniteLoad: false,
                          extent: 40.0,
                          triggerDistance: 50.0,
                          footerBuilder: (context,
                              loadState,
                              pulledExtent,
                              loadTriggerPullDistance,
                              loadIndicatorExtent,
                              axisDirection,
                              float,
                              completeDuration,
                              enableInfiniteLoad,
                              success,
                              noMore) {
                            return Stack(
                              children: <Widget>[
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    child: SpinKitCircle(
                                      color: Colors.green,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              Map _records = socketProvider.records;
                              List<ChatRecord> _record = List<ChatRecord>();
                              if (_records.containsKey(arguments["id"])) {
                                _record = _records[arguments["id"]];
                              } else {
                                _record = [];
                              }
//                              print('包含---${_records.containsKey(arguments["id"])}');
//                              print('全部消息-----${_records['id']}');
//                              print('个人消息-----${_record[index].message},-----${arguments['id']}');
                              return _buildMsg(_record[index]);
                            },
                            childCount: socketProvider?.records[arguments["id"]]?.length ??0,
                          ),
                        ),
                      ],
                      onLoad: () async {},
                    ),
                    onTap: () {
                      setState(() {
                        _height = 0;
                      });
                    },
                  )),
              SafeArea(
                child: Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.keyboard_voice,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            this._height = 0;
                            this.localSocket = socketProvider.socket;
                            this.soundRecording = !this.soundRecording;
                          });
                        },
                      ),
//                          soundRecording ?
//                          Expanded(
//                            flex: 1,
//                            child: VoiceWidget(startRecord: startRecord,stopRecord: stopRecord),
//                          )
//                              :
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            top: 5.0,
                            bottom: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(
                              20,
                            )),
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: 2.0,
                                bottom: 2.0,
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (val) {},
                            onSubmitted: (value) {
                              if (_textEditingController.text.isNotEmpty) {
                                _sendMsg(_textEditingController.text,
                                    socketProvider);
                                _textEditingController.text = '';
                              }
                            },
                            onTap: () {
                              setState(() {
                                _height = 0;
                              });
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              // color: Colors.grey,
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          // 收起键盘
                          // FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            this.soundRecording = false;
                            _height = 100;
                          });
                        },
                      ),
                      // :
                      InkWell(
                        onTap: () {
                          if (_textEditingController.text.isEmpty) {
                            return;
                          }

                          if (_textEditingController.text.isNotEmpty) {
                            _sendMsg(
                                _textEditingController.text, socketProvider);
                            _textEditingController.text = '';
                          }
                        },
                        child: Container(
                          height: 30.0,
                          width: 60.0,
                          alignment: Alignment.center,
                          // margin: EdgeInsets.only(
                          //   left: ScreenAdapter.setWidth(10),
                          // ),
                          decoration: BoxDecoration(
                            // color: _textEditingController.text.isEmpty
                            //     ? Colors.grey
                            //     : Colors.green,
                            color: Color(0xff4ADDFE),
                            borderRadius: BorderRadius.all(Radius.circular(
                              20,
                            )),
                          ),
                          child: Text(
                            '发送',
                            // S.of(context).send,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                  duration: duration,
                  height: _height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Container(
                      child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 120.0, childAspectRatio: 1.0 //宽高比为2
                        ),
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () async {
//                                  var img_url = await Plugins.takePhoto();
//                                  if(img_url!=null){
//                                    setState(() {
//                                      localImage = img_url;
//                                    });
//                                    api.postData(context, 'uploadFile', formData: await formData1(img_url.path)).then((data){
//                                      var imgurl = json.decode(data.toString())['file_path'];
//                                      Map contentArguments = {
//                                        'type':'private_chat',
//                                        'content_type':'img',
//                                        'Content':imgurl,
//                                        'recv_id':arguments['recv_id']
//                                      };
//                                      print(contentArguments);
//                                      Provide.value<SocketProvider>(context).setRecords(localImage,'img', true);
//                                      // socket发送消息
//                                      val.socket.write(json.encode(contentArguments));
//                                    });
//                                  }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.photo),
                        onPressed: () async {
                          print(
                              '---------------------选择图片---------------------');
//                                  var img_url = await Plugins.openGallery();
//                                  if(img_url!=null){
//                                    setState(() {
//                                      localImage = img_url;
//                                    });
//                                    print(localImage);
//                                    api.postData(context, 'uploadFile', formData: await formData1(img_url.path)).then((data){
//                                      var imgurl = json.decode(data.toString())['file_path'];
//                                      print('路径');
//                                      print(imgurl);
//                                      Map contentArguments = {
//                                        'type':'private_chat',
//                                        'content_type':'img',
//                                        'Content':imgurl,
//                                        'recv_id':arguments['recv_id']
//                                      };
//                                      print(json.encode(contentArguments));
//                                      Provide.value<SocketProvider>(context).setRecords(localImage,'img', true);
//                                      // // socket发送消息
//                                      val.socket.write(json.encode(contentArguments));
//                                    });
//                                  }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.videocam),
                        onPressed: () async {
                          print('录像');
//                                  var video_url = await Plugins.takeVideo();
//                                  if(video_url!=null){
//                                    setState(() {
//                                      localVideo = video_url;
//                                    });
//                                    api.postData(context, 'uploadFile', formData: await formData1(video_url.path)).then((data){
//                                      var videourl = json.decode(data.toString())['file_path'];
//                                      Map contentArguments = {
//                                        'type':'private_chat',
//                                        'content_type':'video',
//                                        'Content':videourl,
//                                        'recv_id':arguments['recv_id']
//                                      };
//                                      print(contentArguments);
//                                      Provide.value<SocketProvider>(context).setRecords(localVideo.path,'video', true);
//                                      // socket发送消息
//                                      val.socket.write(json.encode(contentArguments));
//                                    });
//                                  }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.movie),
                        onPressed: () async {
                          print('发送视频');
//                                  var video_url = await Plugins.getVideo();
//                                  //  print(video_url);
//                                  if(video_url!=null){
//                                    setState(() {
//                                      localVideo = video_url;
//                                    });
//
//                                    api.postData(context, 'uploadFile', formData: await formData1(video_url.path)).then((data){
//                                      var videourl = json.decode(data.toString())['file_path'];
//                                      Map contentArguments = {
//                                        'type':'private_chat',
//                                        'content_type':'video',
//                                        'Content':videourl,
//                                        'recv_id':arguments['recv_id']
//                                      };
//                                      print(contentArguments);
//                                      Provide.value<SocketProvider>(context).setRecords(localVideo.path,'video', true);
//                                      // socket发送消息
//                                      val.socket.write(json.encode(contentArguments));
//                                    });
//                                  }
                        },
                      ),
                    ],
                  ))),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        option: {
          "title": arguments["username"],
//          "leading":GestureDetector(child: Icon(Icons.arrow_back),onTap: (){
//            Navigator.pop(context,_lastMessage);
//          }),
        },
        child: _messages());
  }

  // 构建消息视图
  Widget _buildMsg(ChatRecord entity) {
    print('entity.message--->${entity.message}');
    print('entity.newIsMe--->${entity.newIsMe}');
    if (entity == null || entity.newIsMe == null) {
      return Container();
    }
    _lastMessage.addAll({'message':entity.message,'date':DateTime.now()});
    if (entity.newIsMe) {
      return Container(
        margin: EdgeInsets.all(
          10.0,
        ),
        decoration: BoxDecoration(color: Colors.teal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: entity.type == 'text' || entity.type == 'audio'
                          ? Color(0xff4ADDFE)
                          : null,
                      borderRadius: BorderRadius.all(Radius.circular(
                        4.0,
                      )),
                    ),
                    constraints:
                        BoxConstraints(maxWidth: 300.0, maxHeight: 300.0),
                    child: MessageWidget(entity))
              ],
            ),
            Card(
              margin: EdgeInsets.only(
                left: 10.0,
              ),
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              elevation: 0.0,
              child: Container(
                height: 40.0,
                width: 40.0,
                child: Image.asset(
                  'images/login3.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(
          10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(
                right: 10.0,
              ),
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              elevation: 0.0,
              child: Container(
                height: 40.0,
                width: 40.0,
//                child: Image.network('$base_url${arguments['head_pic']}', fit: BoxFit.cover,),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text(
                //   '${arguments['nickname']}',
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 13.0,
                //   ),
                // ),
                Container(
                    margin: EdgeInsets.only(
                      top: 5.0,
                    ),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: entity.type == 'text' || entity.type == 'audio'
                          ? Colors.black12
                          : null,
                      borderRadius: BorderRadius.all(Radius.circular(
                        4.0,
                      )),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: 300.0,
                    ),
                    child: MessageWidget(entity))
              ],
            ),
          ],
        ),
      );
    }
  }

  // 判断显示什么类型的消息
  Widget MessageWidget(entity) {
    switch (entity.type) {
      case 'text':
        return Text(
          entity.message ?? '',
          overflow: TextOverflow.clip,
          style: TextStyle(
            color: entity.newIsMe ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
        );
        break;
      case 'img':
        return entity.newIsMe
            ? InkWell(
                child: Image.file(entity.message),
                onTap: () {
                  print('点了图片');
                  Map arguments = {
                    'imageProvider': FileImage(entity.message),
                    'heroTag': 'simple'
                  };
                  Navigator.pushNamed(context, '/image', arguments: arguments);
                },
              )
            : InkWell(
//          child: Image.network('$base_url${entity.message}'),
                onTap: () {
                  Map arguments = {
//              'imageProvider':NetworkImage('$base_url${entity.message}'),
                    'heroTag': 'simple'
                  };
                  Navigator.pushNamed(context, '/image', arguments: arguments);
                },
              );
        break;
      case 'video':
        return InkWell(
          child: Container(
            width: 300,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Map arguments = {'isMe': entity.newIsMe, 'message': entity.message};

            Navigator.pushNamed(context, '/video', arguments: arguments);
          },
        );
        break;
      case 'audio':
        return Container(
            width: 160,
            child: entity.newIsMe
                ? InkWell(
                    onTap: () {
                      playByPath(entity.message);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${entity.time_length}'),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 50,
                          height: 30,
                          // color: Colors.red,
                          child: Image.asset(
                            'assets/images/recording_right.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      // socket发送来的语音
//                playByPath('$base_url${entity.message}');
                    },
                    child: Row(
                      children: <Widget>[
                        Text('${entity.time_length}'),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 50,
                          height: 30,
                          // color: Colors.red,
                          child: Image.asset(
                            'assets/images/recording_left.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ));
        break;
      default:
        return Text('nothing');
    }
  }

  ///播放指定路径录音文件
  void playByPath(String path) {
//    recordPlugin.playByPath(path);
  }

  // dio上传文件FormData格式
  Future<FormData> formData1(fileUrl) async {
    return FormData.fromMap({"file": await MultipartFile.fromFile(fileUrl)});
  }
}
