import 'package:flutter/material.dart';

class RepoFiles extends StatefulWidget {
  @override
  _RepoFilesState createState() => _RepoFilesState();
}

class _RepoFilesState extends State<RepoFiles> {

  @override
  void initState() {
    super.initState();
    print('print initState files');
  }

  @override
  Widget build(BuildContext context) {
    print('print info page files');

    return Text('info page files');
  }
}