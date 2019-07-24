import 'package:flutter/material.dart';

import '../api/repo.dart';
import '../widgets/Progress.dart';

class RepoInfo extends StatefulWidget {
  RepoInfo(this._repoFullName);

  final String _repoFullName;

  @override
  _RepoInfoState createState() => _RepoInfoState();
}

class _RepoInfoState extends State<RepoInfo> with AutomaticKeepAliveClientMixin {
  Map _repoInfo = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _repoInfo.isNotEmpty
        ? Column(
            children: <Widget>[
              CardBoard(_repoInfo),
            ],
          )
        : centerProgress();
  }

  init() async {
    Map res = await fetchRepoInfo(widget._repoFullName);

    setState(() {
      _repoInfo = res;
    });
  }
}

class CardBoard extends StatelessWidget {
  CardBoard(this._repoInfo);

  final Map _repoInfo;

  @override
  Widget build(BuildContext context) {
    print(_repoInfo.isNotEmpty);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            '${_repoInfo['full_name']}',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text('${_repoInfo['description']}'),
          Row(
            children: [
              _CardRowItem(
                icon: Icon(Icons.error_outline),
                text: '${_repoInfo['open_issues_count']}',
              ),
              _CardRowItem(
                icon: Icon(Icons.star_border),
                text: '${_repoInfo['stargazers_count']}',
              ),
              _CardRowItem(
                icon: Icon(Icons.remove_red_eye),
                text: '${_repoInfo['watchers_count']}',
              ),
              _CardRowItem(
                icon: Icon(Icons.share),
                text: '${_repoInfo['forks_count']}',
              ),
            ],
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
