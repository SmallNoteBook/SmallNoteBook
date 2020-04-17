import 'package:flutter/material.dart';
import 'signPage.dart';
class SignRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/sign': (context, {arguments}) => SignPage(arguments: arguments),
  };

}