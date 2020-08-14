import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<TravelPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("旅拍"),
        )
    );
  }
}