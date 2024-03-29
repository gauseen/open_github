import 'package:flutter/material.dart';

import '../widgets/Progress.dart';

class ScrollLoadMore extends StatefulWidget {
  ScrollLoadMore({
    this.fetchDataHandler,
    this.itemBuilder,
  });

  final fetchDataHandler;
  final itemBuilder;

  @override
  _ScrollLoadMoreState createState() => _ScrollLoadMoreState();
}

class _ScrollLoadMoreState extends State<ScrollLoadMore> {

  int _currentPageNum = 0;
  List dataList = [];
  bool isLocked = false;

  // 下拉加载
  Future<Null> _pullOfRefresh() async {
    if (!mounted) return null;
    
    List data = await widget.fetchDataHandler(pageNum: 1);
    setState(() {
      dataList = data;
    });
    return null;
  }

  // 加载更多
  Future<Null> _loadMore() async {
    if (!mounted) return null;
    
    _currentPageNum++;
    List data = await widget.fetchDataHandler(pageNum: _currentPageNum);
    setState(() {
      dataList.addAll(data);
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
    int length = dataList.length;

    return dataList.isNotEmpty
      ? RefreshIndicator(
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
                    return centerProgress(width: 150.0, height: 3.0, type: 'linear');
                  }

                  var itemData = dataList[index];

                  return widget.itemBuilder(itemData);
                },
              ),
            ),
            onRefresh: _pullOfRefresh,
          )
      : centerProgress();
  }
}
