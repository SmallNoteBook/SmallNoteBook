
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("登陆",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
        elevation: 0, //去掉Appbar底部阴影
      ),
      body: cardWidget(),
    );
  }

  Widget cardWidget(){
    return new Card(
      child: new Column(
        children: <Widget>[
          TextField(
              decoration:InputDecoration(
                border: OutlineInputBorder(),
                hintText: '请账号',
                prefixIcon: Icon(Icons.person),
              )
          ),
          TextField(
              decoration:InputDecoration(
                border: OutlineInputBorder(),
                hintText: '密码',
                prefixIcon: Icon(Icons.vpn_key),
              )
          ),
          new MaterialButton(
            color: Colors.blue,
            minWidth: 400,
            textColor: Colors.white,
            child: new Text('登陆'),
            onPressed: () {
              // ...
            },
          )
        ],
      ),
    );
  }
}