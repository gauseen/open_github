import 'package:flutter/material.dart';
import 'package:open_github/pages/RepoIndex.dart';
import 'app.dart';
import 'pages/WelcomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/RepoIndex.dart';

void main() => runApp(OpenGitHub());

class OpenGitHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub',
      onGenerateRoute: _generateRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
    );
  }
}

// 生成页面路由
RouteFactory _generateRoutes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget page;
    switch (settings.name) {
      case '/':
        page = WelcomePage();
        break;
      case '/home':
        page = MyHomePage();
        break;
      case RepoIndex.routeName:
        page = RepoIndex(arguments['fullName']);
        break;
      case LoginPage.routeName:
        page = LoginPage();
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => page);
  };
}
