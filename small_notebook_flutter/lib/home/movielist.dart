import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
              title: Text('电影海报实例')
          ),
          body: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(10.0),
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.75,
            children: <Widget>[
              Image.network('http://alpha-2115.caibeike.com/i/020bce482215e5b0735b54fe18659b91-9fCunM-AAgwbAghj2'),
              Image.network('http://alpha-2115.caibeike.com/i/020bce482215e5b0735b54fe18659b91-9fCunM-AAgwbAghj2'),
              Image.network('http://alpha-2115.caibeike.com/i/020bce482215e5b0735b54fe18659b91-9fCunM-AAgwbAghj2'),
              Image.network('http://alpha-2115.caibeike.com/i/020bce482215e5b0735b54fe18659b91-9fCunM-AAgwbAghj2'),
              Image.network('http://alpha-2115.caibeike.com/i/020bce482215e5b0735b54fe18659b91-9fCunM-AAgwbAghj2'),
              Image.network('http://alpha-2115.caibeike.com/i/020bce482215e5b0735b54fe18659b91-9fCunM-AAgwbAghj2'),
              new RaisedButton(
                onPressed: () => Navigator.pushNamed(context, '/sign'),
                child: Text('sign'),
              ),
            ],
          ),
        );
  }
}
