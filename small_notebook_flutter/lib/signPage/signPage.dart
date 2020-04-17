
import 'package:flutter/material.dart';

class SignPage extends StatelessWidget {
  final Map arguments;
  SignPage({Key key, this.arguments}) : super(key: key) {
    // print(this.arguments);
  }

  @override
  Widget build(BuildContext context) {
    String tmp = ModalRoute.of(context).settings.arguments.toString();
    String tmp2 = this.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(tmp),
        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.list), onPressed:  ()=>Navigator.pop(context,'title')),
          new IconButton(icon: new Icon(Icons.list), onPressed:  ()=>Navigator.pushNamedAndRemoveUntil(context,'/LoginHome',(route) => route == null)),
        ],
      ),
      body: Center(child: Text(tmp2)),
    );
  }
}