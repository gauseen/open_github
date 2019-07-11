import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  // NewsPage(Key key) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var count = 0;
  List<Color> colors = <Color>[ Colors.yellow, Colors.blue, Colors.green, Colors.orange ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            color: colors[index % 4],
            child: Center(child: Text('index: $index'),),
          );
        },
      ),
    );
  }
}
