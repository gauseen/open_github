// 仓库详情页
import 'package:flutter/material.dart';
import './RepoInfo.dart';
import './RepoFiles.dart';

class RepoIndex extends StatefulWidget {
  static const String routeName = '/repo/info';

  RepoIndex(this._repoFullName);

  final String _repoFullName;

  @override
  _RepoIndexState createState() => _RepoIndexState();
}

class _RepoIndexState extends State<RepoIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Tab>[
              Tab(text: 'Info'),
              Tab(text: 'Files'),
            ],
          ),
          title: Text('Repo'),
        ),
        body: TabBarView(
          children: [
            RepoInfo(widget._repoFullName),
            RepoFiles(),
          ],
        ),
      ),
    );
  }
}
