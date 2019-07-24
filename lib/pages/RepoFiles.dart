import 'package:flutter/material.dart';

class RepoFiles extends StatefulWidget {
  @override
  _RepoFilesState createState() => _RepoFilesState();
}

class _RepoFilesState extends State<RepoFiles> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('print initState files');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    print('print info page files');

    return Center(
      child: Text('coding'),
    );
  }
}