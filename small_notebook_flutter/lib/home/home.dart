import 'package:flutter/material.dart';
import 'package:notebook/components/ScaffoldLayout.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final List<Choice> _tabList = const <Choice>[
    const Choice(title: 'CAR', icon: Icons.directions_car),
    const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
    const Choice(title: 'BOAT', icon: Icons.directions_boat),
    const Choice(title: 'BUS', icon: Icons.directions_bus),
    const Choice(title: 'TRAIN', icon: Icons.directions_railway),
    const Choice(title: 'WALK', icon: Icons.directions_walk),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      child: ScaffoldLayout(
        option: {
          'title': '小日常',
          'bottom': new TabBar(
            isScrollable: true,
            tabs: _tabList.map((Choice choice) {
              return new Tab(
                text: choice.title,
                icon: new Icon(choice.icon),
              );
            }).toList(),
          ),
          'bottomNavigationBar': BottomNavigationBar(
            items:  _tabList.map((Choice choice){
              return new BottomNavigationBarItem(
                    icon: Icon(choice.icon,color: Colors.black,),
                    title: Text(choice.title,style: TextStyle(
                        color: Colors.black
                    ),)
                  );
            }).toList(),
//            items: const <BottomNavigationBarItem>[
//              BottomNavigationBarItem(
//                icon: Icon(Icons.home),
//                title: Text('Home'),
//              ),
//              BottomNavigationBarItem(
//                icon: Icon(Icons.business),
//                title: Text('Business'),
//              ),
//              BottomNavigationBarItem(
//                icon: Icon(Icons.school),
//                title: Text('School'),
//              ),
//            ],
          )
        },
      ),
    );
  }
}
