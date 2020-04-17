import 'package:flutter/material.dart';
import 'home.dart';
import 'movielist.dart';

class HomeRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/home': (BuildContext context) => new Home(),
    '/movie': (BuildContext context) => new MovieList(),
//    '/sign': (context, {arguments}) => SignPage(arguments: arguments),
  };

}