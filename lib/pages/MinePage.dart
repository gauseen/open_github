import 'package:flutter/material.dart';
import '../widgets/AvatarIcon.dart';
import '../api/users.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  Map<String, dynamic> userData = {};
  UserModel userModel;

  @override
  bool get wantKeepAlive => true;

  List _list = [];

  _fetchUsers() async {
    userModel = UserModel.fromJson(await fetchUsers('gauseen'));
    setState(() {
      userData = userModel.toJson();
      _list = [
        {'value': userData['followers'], 'text': 'followers'},
        {'value': userData['following'], 'text': 'following'},
        {'value': userData['publicRepos'], 'text': 'repos'},
        {'value': userData['publicGists'], 'text': 'gists'},
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return userData.isNotEmpty
        ? Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 280.0,
              child: Card(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        AvatarIcon(
                          width: 80.0,
                          height: 80.0,
                          avatarUrl: userData['avatarUrl'],
                        ),
                        SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userData['username'],
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(userData['location']),
                            Text(userData['createdAt']),
                          ],
                        ),
                      ],
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text(userData['email']),
                    ),
                    ListTile(
                      leading: Icon(Icons.link),
                      title: Text(userData['blog']),
                    ),
                    RowTileList(_list),
                  ],
                ),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}

// 横向组
class RowTileList extends StatelessWidget {
  RowTileList(this.list);

  final _style = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w500,
  );

  final List list;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list.map((item) {
        return Column(
          children: <Widget>[
            Text('${item['value']}', style: _style),
            Text(item['text']),
          ],
        );
      }).toList(),
    );
  }
}
