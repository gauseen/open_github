import 'package:flutter/material.dart';

import '../utils/http.dart';

class NewsPage extends StatefulWidget {
  // NewsPage(Key key) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var count = 0;

  Future<Null> _pullOfRefresh() async {
    print('pull...');
    dio.get('/test?tag=1').then((res) => res);
    // await Future.delayed(Duration(seconds: 3));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return NewsItem(index: index,);
          },
        ),
      ),
      onRefresh: _pullOfRefresh,
    );
  }
}

// News 每一项
class NewsItem extends StatelessWidget {
  NewsItem({
    Key key,
    this.index,
    this.avatar,
    this.name,
    this.repoName,
    this.createTime,
  }) : super(key: key);

  final int index;
  final String avatar;
  final String name;
  final String repoName;
  final String createTime;

  List<Color> colors = <Color>[ Colors.yellow, Colors.blue, Colors.green, Colors.orange ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 72.0),
        title: Text('title $index'),
        subtitle: Text('subtitle $index'),
        trailing: Text('trailing $index'),
        onTap: () {
          print('clicked');
        },
      ),
    );
  }
}
