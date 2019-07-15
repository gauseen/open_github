import 'package:flutter/material.dart';
import '../utils/common.dart';
import '../api/events.dart';

class NewsPage extends StatefulWidget {
  // NewsPage(Key key) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _currentPageNum = 0;
  List newsList = [];
  bool isLocked = false;

  // 下拉加载
  Future<Null> _pullOfRefresh() async {
    List data = await fetchEvents(pageNum: 1);
    setState(() {
      newsList = data;
    });
    return null;
  }

  // 加载更多
  Future<Null> _loadMore() async {
    _currentPageNum++;
    List data = await fetchEvents(pageNum: _currentPageNum);
    setState(() {
      newsList.addAll(data);
    });
    isLocked = false;
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    int length = newsList.length;

    return newsList.isEmpty
        ? centerProgress(width: 300.0, type: 'circular')
        : RefreshIndicator(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLocked &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  isLocked = true;
                  _loadMore();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: length + 1,
                itemBuilder: (BuildContext context, int index) {

                  if (index == length) {
                    return centerProgress();
                  }

                  var item = newsList[index];
                  var itemActor = item['actor'];
                  var createTime =
                      Utils.formatTime(DateTime.parse(item['created_at']));

                  return NewsItem(
                    index: index,
                    avatarUrl: itemActor['avatar_url'],
                    login: itemActor['login'],
                    repoName: item['repo']['name'],
                    createTime: createTime,
                  );
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
    this.avatarUrl,
    this.login,
    this.repoName,
    this.createTime,
  }) : super(key: key);

  final int index;
  final String avatarUrl;
  final String login;
  final String repoName;
  final String createTime;

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

// 中间线型加载效果
Widget centerProgress(
    {double width = 150.0, double height = 3.0, String type = 'linear'}) {
  return Center(
    child: Container(
      width: width,
      height: height,
      child: type == 'linear'
          ? LinearProgressIndicator()
          : CircularProgressIndicator(),
    ),
  );
}
