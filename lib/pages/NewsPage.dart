import 'package:flutter/material.dart';
import '../utils/common.dart';
import '../api/events.dart';
import '../widgets/ScrollLoadMore.dart';
import '../widgets/AvatarIcon.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin {
  // 保持页面滚动状态
  @override
  bool get wantKeepAlive => true;

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
    this.fullName = item['repo']['name'];
    this.avatarUrl = itemActor['avatar_url'];
    this.login = itemActor['login'];
    this.repoName = item['repo']['name'];
    this.createTime = Utils.formatTime(DateTime.parse(item['created_at']));
  }

  String avatarUrl;
  String login;
  String repoName;
  String createTime;
  String fullName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: AvatarIcon(avatarUrl: avatarUrl),
            title: Text('$login'),
            trailing: Text('$createTime'),
            onTap: () {
              Navigator.of(context).pushNamed('/repo/info', arguments: {'fullName': fullName});
              print('clicked');
            },
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 5.0),
            child: Text(
              '$repoName',
              maxLines: 2,
            ),
            alignment: Alignment.topLeft,
          ),
        ],
      ),
    );
  }
}
