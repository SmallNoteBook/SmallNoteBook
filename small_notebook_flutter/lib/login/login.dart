import 'package:flutter/material.dart';

class LoginHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Center(
        child: new Wrap(
          children: <Widget>[
            new RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/movie'),
              child: Text('movie'),
            ),
            new RaisedButton(
              onPressed: () async {
                // 获取下一页返回过来数据的方法，打开新页面page3后，便会等着返回，返回此页时就能拿到page3返回的数据
                var res = await Navigator.of(context).pushNamed('/sign',
                    arguments: {
                      "title": "透传title",
                      "name": 'postbird',
                      'passw': '123456'
                    });
                print('res--->$res');
              },
              child: Text('sign'),
            ),
          ],
        ),
      ),
    );
  }
}
