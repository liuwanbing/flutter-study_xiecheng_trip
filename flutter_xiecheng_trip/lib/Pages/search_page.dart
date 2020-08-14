import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("搜索"),
        )
    );
  }
}