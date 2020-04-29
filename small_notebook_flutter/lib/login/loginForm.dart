import 'package:flutter/material.dart';
import 'package:notebook/util/dioUtil/dioUtil.dart';
import 'package:notebook/components/ScaffoldLayout.dart';
import 'package:notebook/util/provider/initSocket.dart';
import 'package:notebook/util/localStorage/Storage.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<Login> {
  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  TextEditingController _username = TextEditingController();
  //  TextEditingController _password = TextEditingController();      //第一种
  dynamic _password; // 第二种
  dynamic _newPassword;
  dynamic _realName;
  dynamic _captcha;
//  final GlobalKey<LoginFormState> captcha = GlobalKey(); //第三种
  int _selectedIndex = 0;
  final List<Choice> _tabList = const <Choice>[
    const Choice(title: '密码登录', icon: Icons.security),
    const Choice(title: '验证码登录', icon: Icons.closed_caption),
    const Choice(title: '注册', icon: Icons.record_voice_over),
    const Choice(title: '找回密码', icon: Icons.settings_cell),
  ];

  @override
  void initState() {
    super.initState();
    this._username.text = 'JinVin';
//    this._password.text = '123';
    this._password = '123';
  }

  void submitLogin() {
//    print(_captcha.validate());
    Widget snackBar(text) {
      return new SnackBar(content: new Text(text));
    }

    // print('click me===>${this._username.text},${this._password}');
    DioUtils.get('http://172.10.3.205:8080/admin/user/login',
        params: {'userName': this._username.text, 'passWord': _password},
        onSuccess: (data) {
      if (data['code'] == 200) {
         Storage.set("userInfo", data['data']).then((val){
           new ClientSocket().connect(context);
//           Navigator.pushNamedAndRemoveUntil(context, '/home',ModalRoute.withName('/'));
         Navigator.pushNamed(context, '/home');
         });
      } else {
        _scaffoldkey.currentState.showSnackBar(snackBar('登录失败，请校验账号密码'));
      }
    });
  }

  Widget imgPanel() {
    return Center(child: Image.asset('images/login.jpeg'));
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      items: _tabList.map((Choice choice) {
        return new BottomNavigationBarItem(
            icon: Icon(
              choice.icon,
              color: Colors.black,
            ),
            title: Text(
              choice.title,
              style: TextStyle(color: Colors.black),
            ));
      }).toList(),
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Widget formPanel() {
    final padding = Padding(
      padding: new EdgeInsets.all(10),
    );
    final userName = TextFormField(
      key: Key('userName'),
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
    );
    final password = TextFormField(
//              obscureText: true,
      key: Key('password'),
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
    );

    final captcha = TextFormField(
      key: Key('captcha'),
      onSaved: (value) {
        print('value===>$value');
      },
      onChanged: (value) => this._captcha = value,
      decoration: const InputDecoration(
          labelText: "请输入验证码",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pink,
            ),
          ),
          icon: Icon(Icons.closed_caption)),
      validator: (value) {
        if (value.isEmpty) {
          return '请输入验证码';
        }
        return null;
      },
    );

    final realName = TextFormField(
      key: Key('realname'),
      initialValue: this._realName,
      onSaved: (value) {
        print('value===>$value');
      },
      onChanged: (value) => this._realName = value,
      decoration: const InputDecoration(
          labelText: "请输入姓名",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pink,
            ),
          ),
          icon: Icon(Icons.recent_actors)),
      validator: (value) {
        if (value.isEmpty) {
          return '请输入姓名';
        }
        return null;
      },
    );

    final newPassword = TextFormField(
      key: Key('newPassword'),
      initialValue: this._newPassword,
      onSaved: (value) {
        print('value===>$value');
      },
      onChanged: (value) => this._newPassword = value,
      decoration: const InputDecoration(
          labelText: "请输入新密码",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pink,
            ),
          ),
          icon: Icon(Icons.security)),
      validator: (value) {
        if (value.isEmpty) {
          return '请输入新密码';
        }
        return null;
      },
    );

    List<Widget> _selectLoginType = new List();
    List<Widget> _selectLoginType1 = new List();
    List<Widget> _selectLoginType2 = new List();
    List<Widget> _selectLoginType3 = new List();
    _selectLoginType = [userName, padding, password];
    _selectLoginType1 = [userName, padding, captcha];
    _selectLoginType2 = [realName, padding, userName, padding, password];
    _selectLoginType3 = [realName, padding, userName, padding, newPassword];

    return Center(
      child: Padding(
        padding: new EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
        child: Column(
//          children: <Widget>[userName, padding, password, padding, captcha],
          children: [
            _selectLoginType,
            _selectLoginType1,
            _selectLoginType2,
            _selectLoginType3
          ].elementAt(_selectedIndex),
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
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text('微信登录',
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
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text('登录1',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      child: ScaffoldLayout(
        option: {
//          'bottom': new TabBar(
//            isScrollable: true,
//            tabs: _tabList.map((Choice choice) {
//              return new Tab(
//                text: choice.title,
//                icon: new Icon(choice.icon),
//              );
//            }).toList(),
//          ),
          'key': _scaffoldkey,
          'bottomNavigationBar': _bottomNavigationBar()
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              //MainAxisAlignment：主轴方向上的对齐方式，会对child的位置起作用，默认是start。
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                imgPanel(),
                formPanel(),
                buttonPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
