import 'package:flutter/material.dart';
import 'home.dart';
import 'movielist.dart';
import 'package:notebook/home/message/chatPage.dart';

class HomeRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/home': (BuildContext context) => new Home(),
    '/movie': (BuildContext context) => new MovieList(),
    '/chat': (context, {arguments}) => ChatPage(arguments: arguments),
  };

}