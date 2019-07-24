import 'package:flutter/material.dart';
import '../api/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username;
  String _password;
  bool isLocked = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 420.0,
          margin: EdgeInsets.only(top: 100.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Card(
            elevation: 16.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    child: ClipOval(
                      child: Center(
                        child: Image.asset('assets/images/github.png',
                            width: 100.0),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          onSaved: (value) => _username = value,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value,
                        ),
                        SizedBox(height: 21.0),
                        FloatingActionButton.extended(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          label: Container(
                            width: 130.0,
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          onPressed: () async {
                            if (isLocked) return;

                            if (_formKey.currentState.validate()) {
                              isLocked = true;
                              _formKey.currentState.save();

                              try {
                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                var res = await login(_username, _password);
                                var username = res.data['login'];
                                await prefs.setString('username', username);

                                Navigator.of(context)
                                    .pushReplacementNamed('/home');
                              } catch (e) {
                                alert(context, '无效的用户名或密码');
                              }

                              isLocked = false;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

alert(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('提示'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(content ?? 'none'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
