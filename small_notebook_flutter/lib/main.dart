import 'package:flutter/material.dart';
import 'package:notebook/login/loginForm.dart';
import 'package:notebook/home/routes.dart';
import 'package:notebook/signPage/routes.dart';
import 'package:provider/provider.dart';
import 'package:notebook/util/provider/SocketProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        builder: (_) => SocketProvider(),
      )
    ],
    child: MyApp(),
  ));
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> _routes = {};
    _routes.addAll(HomeRoutes.routes);
    _routes.addAll(SignRoutes.routes);

    Route _routeGenerator(RouteSettings settings) {
      final String name = settings.name;
      final Function pageBuilder = _routes[name];
      if (pageBuilder != null) {
        if (settings.arguments != null) {
          // 如果传了参数
          return MaterialPageRoute(
              builder: (context) =>
                  pageBuilder(context, arguments: settings.arguments));
        } else {
          // 没有传参数
          return MaterialPageRoute(builder: (context) => pageBuilder(context));
        }
      }
      return MaterialPageRoute(builder: (context) => Login());
    }

    return MaterialApp(
      title: 'Flutter Demo',
//     routes: _routes,
      initialRoute: '/',
      onGenerateRoute: _routeGenerator,
    );
  }
}
