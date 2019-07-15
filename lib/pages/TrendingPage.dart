import 'package:flutter/material.dart';
import '../utils/common.dart';
import '../api/events.dart';
import '../widgets/ScrollLoadMore.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    return ScrollLoadMore(
      fetchDataHandler: fetchEvents,
      itemBuilder: (item) {
        return NewsItem(item);
      },
    );
  }
}

// News 每一项
class NewsItem extends StatelessWidget {

  NewsItem(item) {
    var itemActor = item['actor'];
    this.avatarUrl = itemActor['avatar_url'];
    this.login = itemActor['login'];
    this.repoName = item['repo']['name'];
    this.createTime = Utils.formatTime(DateTime.parse(item['created_at']));
  }

  String avatarUrl;
  String login;
  String repoName;
  String createTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FadeInImage.assetNetwork(
            placeholder: 'assets/images/avatar.png', image: '$avatarUrl'),
        title: Text('$login'),
        subtitle: Text('$repoName'),
        trailing: Text('$createTime'),
        onTap: () {
          print('clicked');
        },
      ),
    );
  }
}
