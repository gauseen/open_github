import 'package:flutter/material.dart';
import 'package:open_github/pages/RepoIndex.dart';
import 'pages/NewsPage.dart';
import 'pages/TrendingPage.dart';
import 'pages/MinePage.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _homePages = <Widget>[];
  List<String> appBars = <String>[];

  @override
  void initState() {
    super.initState();
    _homePages = <Widget>[NewsPage(), TrendingPage(), MinePage()];
    appBars = <String>['News', 'Trending', 'Mine'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 页面 title
      appBar: AppBar(
        title: Text(appBars[_currentIndex]),
      ),
      // 页面主要内容
      // PageView 保持页面状态
      body: PageView(
        controller: _pageController,
        children: _homePages,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(), // 是否可左右滑动
      ),
      // 底部导航按钮
      bottomNavigationBar: BottomNavigationBar(
        items: _generateBottomNavItem(),
        currentIndex: _currentIndex,
        // 点击导航时的回调函数
        onTap: _onTap,
      ),
    );
  }

  // 底部导航回调
  _onTap(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  // 页面左右滑动时回调
  _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

// 生成页面路由
RouteFactory _generateRoutes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget page;
    switch (settings.name) {
      case RepoIndex.routeName:
        page = RepoIndex(arguments['fullName']);
        break;
      case '/b':
        page = Text('Page b');
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => page);
  };
}

// 生成底部导航
List<BottomNavigationBarItem> _generateBottomNavItem() {
  return <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('News'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.trending_up),
      title: Text('Trending'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Mine'),
    ),
  ];
}
