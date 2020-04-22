import 'package:flutter/material.dart';
import 'package:notebook/components/ScaffoldLayout.dart';
import 'package:notebook/home/message/message.dart';
import 'contact.dart';
import 'relation.dart';
import 'share.dart';
import 'package:notebook/home/message/chatPage.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Choice> _tabList = const <Choice>[
    const Choice(title: '消息', icon: Icons.message),
    const Choice(title: '通讯录', icon: Icons.contact_phone),
    const Choice(title: '关系', icon: Icons.accessibility),
    const Choice(title: '分享', icon: Icons.share),
  ];

  Widget _bottomNavigationBar(){
    return BottomNavigationBar(
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      child: ScaffoldLayout(
        option: {
          'title': '小日常',
//          'bottom': new TabBar(
//            isScrollable: true,
//            tabs: _tabList.map((Choice choice) {
//              return new Tab(
//                text: choice.title,
//                icon: new Icon(choice.icon),
//              );
//            }).toList(),
//          ),
          'bottomNavigationBar':_bottomNavigationBar()
        },
        child: [
          new ChatPage({'nickname':'jv'}),
//          new Message(),
          new Contact(),
          new Relation(),
          new Share()
        ].elementAt(_selectedIndex),
      ),
    );
  }
}
