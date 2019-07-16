import 'package:flutter/material.dart';

class RepoInfo extends StatefulWidget {
  @override
  _RepoInfoState createState() => _RepoInfoState();
}

class _RepoInfoState extends State<RepoInfo> {
  @override
  void initState() {
    super.initState();
    print('print initState');
  }

  @override
  Widget build(BuildContext context) {
    print('print info page');

    return Column(
      children: <Widget>[
        CardBoard(),
      ],
    );
  }
}

class CardBoard extends StatelessWidget {
  final List<_CardRowItem> cardRowItemList = <_CardRowItem>[
    _CardRowItem(
      icon: Icon(Icons.error_outline),
      text: 'Issues',
    ),
    _CardRowItem(
      icon: Icon(Icons.star_border),
      text: 'Star',
    ),
    _CardRowItem(
      icon: Icon(Icons.share),
      text: 'Fork',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'gausee/seed',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Text('gausee/seed hahah',
              style: TextStyle(
                fontSize: 16.0,
              )),
          Row(
            children: cardRowItemList,
          ),
        ],
      ),
    );
  }
}

class _CardRowItem extends StatelessWidget {
  _CardRowItem({
    this.icon,
    this.text,
  });

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Tab(
          icon: icon,
          text: text,
        ),
      ),
    );
  }
}
