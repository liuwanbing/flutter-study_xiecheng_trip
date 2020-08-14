import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("我的"),
        )
    );
  }
}