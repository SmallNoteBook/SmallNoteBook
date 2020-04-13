import 'package:flutter/material.dart';
import 'dart:async';
import 'LoginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '小本本',
      home: new SplashScreen(),
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFFF5F5F5,
          <int, Color>{
            50: Color(0xFFFAFAFA),
            100: Color(0xFFF5F5F5),
            200: Color(0xFFEEEEEE),
            300: Color(0xFFE0E0E0),
            350: Color(0xFFD6D6D6), // only for raised button while pressed in light theme
            400: Color(0xFFBDBDBD),
            500: Color(0xFFEEEEEE),
            600: Color(0xFF757575),
            700: Color(0xFF616161),
            800: Color(0xFF424242),
            850: Color(0xFF303030), // only for background color in dark theme
            900: Color(0xFF212121),
          },
        ),  //定义主题风格    primarySwatch
      ),
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => new LoginScreen() // 首页widget类，省略了
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 2);
    _timer = new Timer(_duration, navigationPage);
    return _timer;
  }

  void navigationPage() {
    _timer.cancel();
    Navigator.of(context).pushReplacementNamed('/main');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: new Image.asset(
          "images/start.jpeg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

