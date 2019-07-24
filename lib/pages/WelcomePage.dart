import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    auth();
  }

  auth() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('authorization');
    print(token);
    await Future.delayed(Duration(seconds: 1));

    if (token == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
    } else {
      // Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
      Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            // 'Welcome Open GitHub',
            '来了？老弟！',
            style: TextStyle(fontSize: 21.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
