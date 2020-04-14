
import 'package:flutter/material.dart';
import 'package:notebook/components/ScaffoldLayout.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
      child:LoginForm() ,
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  TextEditingController _username = TextEditingController();
  //  TextEditingController _password = TextEditingController();      //第一种
  dynamic _password; // 第二种
  final GlobalKey<LoginFormState> captcha = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._username.text = 'JinVin';
//    this._password.text = '123';
    this._password = '10086';
  }

  void submitLogin() {
    // print('click me===>${this._username.text},${this._password.text}');
//    print(_captcha.validate());
    print('click me===>${this._username.text},${this._password}');
    Navigator.pushNamed(context,'/home');
//    showDialog(
//        context: context,
//        builder: (_) {
//          return AlertDialog(
//            title: Text("对话框"),
//            content: Text(this._username.text +
//                "\n" +
//                this._password),
//            actions: <Widget>[
//              //对话框里面的两个按钮
//              FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                  child: Text("取消")),
//              FlatButton(
//                //点击确定跳转到下一个界面，也就是HomePage
//                  onPressed: () {
//                    Navigator.pushNamed(context,'/home');
//                  },
//                  child: Text("确定")),
//            ],
//          );
//        });
  }

  @override
  Widget build(BuildContext context) {
    return loginPanel();
  }

  Widget loginPanel() {
    return Padding(
      padding: new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        //MainAxisAlignment：主轴方向上的对齐方式，会对child的位置起作用，默认是start。
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[imgPanel(), formPanle(), buttonPanel()],
      ),
    );
  }

  Widget imgPanel() {
    return Center(child: Image.asset('images/login.jpeg'));
  }

  Widget formPanle() {
    return Center(
      child: Padding(
        padding: new EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: this._username,
              decoration: const InputDecoration(
                  hintText: 'example@163.com',
                  labelText: "请输入手机号/邮箱",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                  icon: Icon(Icons.account_box)),
              validator: (value) {
                if (value.isEmpty) {
                  return '请输入账号4';
                }
                return null;
              },
            ),
            Padding(
              padding: new EdgeInsets.all(10),
            ),
            TextFormField(
//              obscureText: true,
              initialValue: this._password,
              onChanged: (value) => this._password = value,
              decoration: const InputDecoration(
                  hintText: '***********',
                  labelText: "请输入密码",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                  icon: Icon(Icons.security)),
              validator: (value) {
                if (value.isEmpty) {
                  return '请输入密码4';
                }
                return null;
              },
            ),
            Padding(
              padding: new EdgeInsets.all(10),
            ),
            TextFormField(
              key: captcha,
              onSaved: (value) {
                print('value===>$value');
              },
              onChanged: (value) => this._password = value,
              decoration: const InputDecoration(
                  labelText: "请输入验证码",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                  icon: Icon(Icons.security)),
              validator: (value) {
                if (value.isEmpty) {
                  return '请输入验证码';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonPanel() {
//    return RaisedButton(onPressed: null, child: Text('进入天网'));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: submitLogin,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
//              gradient: LinearGradient(
//                colors: <Color>[
//                  Color(0xFF0D47A1),
//                  Color(0xFF1976D2),
//                  Color(0xFF42A5F5),
//                ],
//              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text('注册天网',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
          ),
        ),
        GestureDetector(
          onTap: submitLogin,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
//              gradient: LinearGradient(
//                colors: <Color>[
//                  Color(0xFF0D47A1),
//                  Color(0xFF1976D2),
//                  Color(0xFF42A5F5),
//                ],
//              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text('进入天网',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
          ),
        ),
      ],
    );
  }
}
