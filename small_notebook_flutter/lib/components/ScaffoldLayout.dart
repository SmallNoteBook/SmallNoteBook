import 'package:flutter/material.dart';

class ScaffoldLayout extends StatelessWidget {
  ScaffoldLayout(
      {Key key, this.child, Map<dynamic, dynamic> this.option = const {}})
      : super(key: key);
  final child;
  final option;

  Widget build(BuildContext context) {
    List<Widget> _actions = List();
    _actions = this.option['actions'] ?? [];
    return Scaffold(
        key: this.option['key'] ?? null,
        appBar: AppBar(
          title: Text(this.option['title'] ?? '登录'),
          backgroundColor: this.option['backgroundColor'] ?? Colors.black,
          actions: _actions,
          bottom: this.option['bottom'] ?? null,
        ),
        body: Builder(builder: (BuildContext context) {
          return Container(
            //设置背景图片
//          decoration: BoxDecoration(
//            image: DecorationImage(
//                image: AssetImage('images/login2.jpeg'),
//                fit: BoxFit.cover
//            ),
//          ),
            child: SingleChildScrollView(child: child),
          );
        }),
        bottomNavigationBar: this.option['bottomNavigationBar'] ?? null);
  }
}
