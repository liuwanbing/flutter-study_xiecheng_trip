
import 'package:flutter/material.dart';
import 'package:flutterxiechengtrip/Model/grid_nav_model.dart';

class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;

  //@required表示参数是必须的
  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('gridNav_widget');
  }
}