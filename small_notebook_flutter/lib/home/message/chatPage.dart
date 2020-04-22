//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';
////import 'package:example/generated/i18n.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//
///// 聊天界面示例
//class ChatPage extends StatefulWidget {
//  @override
//  ChatPageState createState() {
//    return ChatPageState();
//  }
//}
//
//class ChatPageState extends State<ChatPage> {
//  // 信息列表
//  List<MessageEntity> _msgList;
//
//  // 输入框
//  TextEditingController _textEditingController;
//  // 滚动控制器
//  ScrollController _scrollController;
//
//  @override
//  void initState() {
//    super.initState();
//    _msgList = [
//      MessageEntity(true, "It's good!"),
//      MessageEntity(false, 'EasyRefresh'),
//    ];
//    _textEditingController = TextEditingController();
//    _textEditingController.addListener(() {
//      setState(() {});
//    });
//    _scrollController = ScrollController();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _textEditingController.dispose();
//    _scrollController.dispose();
//  }
//
//  // 发送消息
//  void _sendMsg(String msg) {
//    setState(() {
//      _msgList.insert(0, MessageEntity(true, msg));
//    });
//    _scrollController.animateTo(0.0,
//        duration: Duration(milliseconds: 300), curve: Curves.linear);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('KnoYo'),
//        centerTitle: false,
//        backgroundColor: Colors.grey[200],
//        elevation: 0.0,
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.more_horiz),
//            onPressed: () {},
//          ),
//        ],
//      ),
//      backgroundColor: Colors.grey[200],
//      body: Column(
//        children: <Widget>[
//          Divider(
//            height: 0.5,
//          ),
//          Expanded(
//            flex: 1,
//            child: EasyRefresh.custom(
//              scrollController: _scrollController,
//              reverse: true,
//              footer: CustomFooter(
//                  enableInfiniteLoad: true,
//                  extent: 40.0,
//                  triggerDistance: 50.0,
//                  footerBuilder: (context,
//                      loadState,
//                      pulledExtent,
//                      loadTriggerPullDistance,
//                      loadIndicatorExtent,
//                      axisDirection,
//                      float,
//                      completeDuration,
//                      enableInfiniteLoad,
//                      success,
//                      noMore) {
//                    return Stack(
//                      children: <Widget>[
//                        Positioned(
//                          bottom: 0.0,
//                          left: 0.0,
//                          right: 0.0,
//                          child: Container(
//                            width: 30.0,
//                            height: 30.0,
//                            child: SpinKitCircle(
//                              color: Colors.green,
//                              size: 30.0,
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//                  }),
//              slivers: <Widget>[
//                SliverList(
//                  delegate: SliverChildBuilderDelegate(
//                    (context, index) {
//                      return _buildMsg(_msgList[index]);
//                    },
//                    childCount: _msgList.length,
//                  ),
//                ),
//              ],
//              onLoad: () async {
//                await Future.delayed(Duration(seconds: 2), () {
//                  if (mounted) {
//                    setState(() {
//                      _msgList.addAll([
//                        MessageEntity(true, "It's good!"),
//                        MessageEntity(false, 'EasyRefresh'),
//                      ]);
//                    });
//                  }
//                });
//              },
//            ),
//          ),
//          SafeArea(
//            child: Container(
//              color: Colors.grey[100],
//              padding: EdgeInsets.only(
//                left: 15.0,
//                right: 15.0,
//                top: 8.0,
//                bottom: 8.0,
//              ),
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      padding: EdgeInsets.only(
//                        left: 5.0,
//                        right: 5.0,
//                      ),
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.all(Radius.circular(
//                          4.0,
//                        )),
//                      ),
//                      child: TextField(
//                        controller: _textEditingController,
//                        decoration: InputDecoration(
////                          contentPadding: EdgeInsets.only(
////                            top: 2.0,
////                            bottom: 2.0,
////                          ),
//                          border: InputBorder.none,
//                        ),
//                        onSubmitted: (value) {
//                          if (_textEditingController.text.isNotEmpty) {
//                            _sendMsg(_textEditingController.text);
//                            _textEditingController.text = '';
//                          }
//                        },
//                      ),
//                    ),
//                  ),
//                  InkWell(
//                    onTap: () {
//                      if (_textEditingController.text.isNotEmpty) {
//                        _sendMsg(_textEditingController.text);
//                        _textEditingController.text = '';
//                      }
//                    },
//                    child: Container(
//                      height: 30.0,
//                      width: 60.0,
//                      alignment: Alignment.center,
//                      margin: EdgeInsets.only(
//                        left: 15.0,
//                      ),
//                      decoration: BoxDecoration(
//                        color: _textEditingController.text.isEmpty
//                            ? Colors.grey
//                            : Colors.green,
//                        borderRadius: BorderRadius.all(Radius.circular(
//                          4.0,
//                        )),
//                      ),
//                      child: Text(
////                        S.of(context).send,
//                        '发送',
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 16.0,
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  // 构建消息视图
//  Widget _buildMsg(MessageEntity entity) {
//    if (entity == null || entity.own == null) {
//      return Container();
//    }
//    if (entity.own) {
//      return Container(
//        margin: EdgeInsets.all(
//          10.0,
//        ),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.end,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: <Widget>[
////                Text(
////                  'bala bala ...  me',
////                  style: TextStyle(
////                    color: Colors.grey,
////                    fontSize: 13.0,
////                  ),
////                ),
//                Container(
////                  margin: EdgeInsets.only(
////                    top: 1.0,
////                  ),
//                  padding: EdgeInsets.all(10.0),
//                  decoration: BoxDecoration(
//                    color: Colors.lightGreen,
//                    borderRadius: BorderRadius.all(Radius.circular(
//                      4.0,
//                    )),
//                  ),
//                  constraints: BoxConstraints(
//                    maxWidth: 200.0,
//                  ),
//                  child: Text(
//                    entity.msg ?? '',
//                    overflow: TextOverflow.clip,
//                    style: TextStyle(
//                      fontSize: 16.0,
//                    ),
//                  ),
//                )
//              ],
//            ),
//            Card(
//              margin: EdgeInsets.only(
//                left: 10.0,
//              ),
//              clipBehavior: Clip.hardEdge,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(20.0)),
//              ),
//              elevation: 0.0,
//              child: Container(
//                height: 40.0,
//                width: 40.0,
//                child: Image.asset('assets/image/head.jpg'),
//              ),
//            ),
//          ],
//        ),
//      );
//    } else {
//      return Container(
//        decoration: BoxDecoration(
//          color: Colors.cyan
//        ),
//        margin: EdgeInsets.all(
//          10.0,
//        ),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Card(
//              margin: EdgeInsets.only(
//                right: 10.0,
//              ),
//              clipBehavior: Clip.hardEdge,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(20.0)),
//              ),
//              elevation: 0.0,
//              child: Container(
//                height: 40.0,
//                width: 40.0,
//                child: Image.asset('images/login3.jpeg'),
//              ),
//            ),
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
////                Text(
////                  'KnoYo',
////                  style: TextStyle(
////                    color: Colors.grey,
////                    fontSize: 13.0,
////                  ),
////                ),
//                Container(
////                  margin: EdgeInsets.only(
////                    top: 1.0,
////                  ),
//                  padding: EdgeInsets.all(10.0),
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.all(Radius.circular(
//                      4.0,
//                    )),
//                  ),
//                  constraints: BoxConstraints(
//                    maxWidth: 200.0,
//                  ),
//                  child: Text(
//                    entity.msg ?? '',
//                    overflow: TextOverflow.clip,
//                    style: TextStyle(
//                      fontSize: 16.0,
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ],
//        ),
//      );
//    }
//  }
//}
//
///// 信息实体
//class MessageEntity {
//  bool own;
//  String msg;
//
//  MessageEntity(this.own, this.msg);
//}




import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notebook/util/provider/SocketProvider.dart';
import 'package:provider/provider.dart';
/// 聊天界面
class ChatPage extends StatefulWidget {
  final arguments;
  ChatPage(this.arguments);
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
  bool soundRecording = false;      // 是否显示语音按钮
  double _height = 0;               // 控制操作栏的高度
  var localSocket;
  var localImage, localVideo;       // 本地图片和视频
  var audioPath;                    // 语音路径
  var duration = Duration(milliseconds: 200);


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
  void _sendMsg(String msg) {
    // 存储文字消息
    Provider.of<SocketProvider>(context, listen: false).setRecords(msg,'text', true);
    _scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  startRecord(){
    print("111开始录制");
  }

  stopRecord(String path,double audioTimeLength ) async {
    print("结束束录制");
    print("音频文件位置"+path);
    print("音频录制时长"+audioTimeLength.toString());
    setState(() {
      this.audioPath = path;
    });

//    api.postData(context, 'uploadFile', formData: await FormData1(path)).then((data){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(IconData(0xe622, fontFamily: 'myIcon'), size: 40.0,), onPressed: ()=>Navigator.pop(context),),
          title: Container(
            child:  Text('${arguments['nickname']}', style: TextStyle(fontSize: 35.0),),
          ),
          centerTitle: true,
          // backgroundColor: Colors.grey[200],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.people),
              onPressed: (){
                print('更多');
              },
            )
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: Consumer<SocketProvider>(
          builder: (context,socketProvider, child){
            return Container(
              color: Colors.white,
              child:  Column(
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
                                  return _buildMsg(socketProvider.records[index]);
                                },
                                childCount: socketProvider.records.length,
                              ),
                            ),
                          ],
                          onLoad: () async {


                          },
                        ),
                        onTap: (){
                          setState(() {
                            _height = 0;
                          });
                        },
                      )
                  ),

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
                              margin: EdgeInsets.only(right:10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(Icons.keyboard_voice, color: Colors.grey,),
                            ),
                            onTap: (){
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
                                onChanged: (val){

                                },
                                onSubmitted: (value) {
                                  if (_textEditingController.text.isNotEmpty) {
                                    _sendMsg(_textEditingController.text);
                                    _textEditingController.text = '';
                                  }
                                },
                                onTap: (){
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
                                  border: Border.all(width:0.5, color: Colors.grey)
                              ),
                              child: Icon(Icons.add, color: Colors.grey,),
                            ),
                            onTap: (){
                              // 收起键盘
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                this.soundRecording = false;
                                _height = 100;
                              });
                            },
                          ),
                          // :
                          InkWell(
                            onTap: () {
                              if(_textEditingController.text.isEmpty){
                                return;
                              }
                              Map contentArguments = {
                                'type':'private_chat',
                                'content_type':'text',
                                'Content':_textEditingController.text,
                                'recv_id':arguments['recv_id']
                              };
                              print(contentArguments);
                              if (_textEditingController.text.isNotEmpty) {
                                _sendMsg(_textEditingController.text);
                                _textEditingController.text = '';
                              }
                              // socket发送消息
                              socketProvider.socket.write(json.encode(contentArguments));
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
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
                                maxCrossAxisExtent: 120.0,
                                childAspectRatio: 1.0 //宽高比为2
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
//                                    api.postData(context, 'uploadFile', formData: await FormData1(img_url.path)).then((data){
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
                                  print('---------------------选择图片---------------------');
//                                  var img_url = await Plugins.openGallery();
//                                  if(img_url!=null){
//                                    setState(() {
//                                      localImage = img_url;
//                                    });
//                                    print(localImage);
//                                    api.postData(context, 'uploadFile', formData: await FormData1(img_url.path)).then((data){
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
//                                    api.postData(context, 'uploadFile', formData: await FormData1(video_url.path)).then((data){
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
//                                    api.postData(context, 'uploadFile', formData: await FormData1(video_url.path)).then((data){
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
                          )
                      )
                  ),
                ],
              )
              ,
            );

          },
        )
    );
  }

  // 构建消息视图
  Widget _buildMsg(ChatRecord entity) {
    if (entity == null || entity.newIsMe == null || userInfo == null) {
      return Container();
    }
    if (entity.newIsMe) {
      return Container(
        margin: EdgeInsets.all(
          10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(
                      top: 5.0,
                    ),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: entity.type == 'text' || entity.type == 'audio' ? Color(0xff4ADDFE) : null,
                      borderRadius: BorderRadius.all(Radius.circular(
                        4.0,
                      )),
                    ),
                    constraints: BoxConstraints(
                        maxWidth: 300.0,
                        maxHeight: 300.0
                    ),
                    child: MessageWidget(entity)
                )
              ],
            ),
            Card(
              margin: EdgeInsets.only(
                left: 10.0,
              ),
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              elevation: 0.0,
              child: Container(
                height: 40.0,
                width: 40.0,
//                child: Image.network('$base_url${userInfo['head_pic']}', fit: BoxFit.cover,),
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
                      color: entity.type == 'text' || entity.type == 'audio' ? Colors.black12 : null,
                      borderRadius: BorderRadius.all(Radius.circular(
                        4.0,
                      )),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: 300.0,
                    ),
                    child: MessageWidget(entity)
                )
              ],
            ),
          ],
        ),
      );
    }
  }

  // 判断显示什么类型的消息
  Widget MessageWidget(entity){
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
        return entity.newIsMe  ?
        InkWell(
          child: Image.file(entity.message),
          onTap: (){
            print('点了图片');
            Map arguments = {
              'imageProvider':FileImage(entity.message),
              'heroTag':'simple'
            };
            Navigator.pushNamed(context, '/image', arguments: arguments);
          },
        )
            :
        InkWell(
//          child: Image.network('$base_url${entity.message}'),
          onTap: (){
            Map arguments = {
//              'imageProvider':NetworkImage('$base_url${entity.message}'),
              'heroTag':'simple'
            };
            Navigator.pushNamed(context, '/image', arguments: arguments);
          },
        );
        break;
      case 'video':
        return  InkWell(
          child: Container(
            width: 300,
            height:150,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
            ),
            alignment: Alignment.center,
            child: Icon(Icons.play_arrow, color: Colors.white,),
          ),
          onTap: (){
            Map arguments = {
              'isMe':entity.newIsMe,
              'message':entity.message
            };


            Navigator.pushNamed(context, '/video', arguments: arguments);
          },
        );
        break;
      case 'audio':
        return Container(
            width: 160,
            child: entity.newIsMe ?
            InkWell(
              onTap: (){

                playByPath(entity.message);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${entity.time_length}'),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 50,
                    height:30,
                    // color: Colors.red,
                    child: Image.asset('assets/images/recording_right.png', fit: BoxFit.cover,),
                  )
                ],
              ),
            )
                :
            InkWell(
              onTap: (){
                // socket发送来的语音
//                playByPath('$base_url${entity.message}');
              },
              child: Row(
                children: <Widget>[
                  Text('${entity.time_length}'),
                  Container(
                    margin: EdgeInsets.only(left:10),
                    width: 50,
                    height: 30,
                    // color: Colors.red,
                    child: Image.asset('assets/images/recording_left.png', fit: BoxFit.cover,),
                  )
                ],
              ),
            )

        );
        break;
      default:
    }
  }


  ///播放指定路径录音文件
  void playByPath(String path) {
//    recordPlugin.playByPath(path);
  }

  // dio上传文件FormData格式
  Future<FormData> FormData1(fileUrl) async {
    return FormData.fromMap({
      "file": await MultipartFile.fromFile(fileUrl)
    });
  }
}
