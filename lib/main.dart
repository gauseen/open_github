import 'package:flutter/material.dart';
import 'pages/NewsPage.dart';

void main() => runApp(OpenGitHub());

class OpenGitHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub',
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
  List<Widget> pages = <Widget>[];

  @override
  void initState() {
    pages = <Widget>[ NewsPage(), Text('2'), Text('3') ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 页面 title
      appBar: AppBar(
        title: Text('Open GitHub'),
      ),
      // 页面主要内容
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        // 根据 _currentIndex 显示对应的 Widget
        child: IndexedStack(
          children: pages,
          index: _currentIndex,
        ),
      ),
      // 底部导航按钮
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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
        ],
        currentIndex: _currentIndex,
        // 点击导航时的回调函数
        onTap: (int index) {
          setState(() {
           _currentIndex = index;
          });
        },
      ),
    );
  }
}
