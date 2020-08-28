import 'package:flutter/material.dart';
import 'package:http/http.dart';

//加载进度条组件
class LoadingContainer extends StatelessWidget{

  final Widget child;//具体呈现的内容
  final isLoading;//是否正在加载
  final cover;//是否放在child之上
  const LoadingContainer({Key,key,@required this.child, @required this.isLoading, this.cover = false}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //不是cover 和不是loading 的情况下，显示child,否则显示_loadingView
    return !cover? !isLoading? child : _loadingView:Stack(
      children: <Widget>[child,
        isLoading?_loadingView:null],
    );
  }

  Widget get _loadingView{
    return Center(
      child: CircularProgressIndicator(),
    );
  }



}