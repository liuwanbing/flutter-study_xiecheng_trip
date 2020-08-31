
import 'package:flutter/material.dart';
import 'package:flutterxiechengtrip/Model/grid_nav_model.dart';
import 'package:flutterxiechengtrip/Model/local_navlist_model.dart';
import 'package:flutterxiechengtrip/Widget/webview.dart';

class SubNav extends StatelessWidget {

  final List<CommonModel> subNavList;

  //@required表示参数是必须的
  const SubNav({Key key,@required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if(subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model){
      items.add(_item(context,model));
    });
    int separete = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //排列方式
          children: items.sublist(0,separete),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //排列方式
            children: items.sublist(separete,items.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              WebView(url: model.url,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
          ));
        },
        child: Column(
          children: <Widget>[
            Image.network(
              model.icon,
              height: 18,
              width: 18,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(model.title),
            ),
          ],
        ),
      ),
    );
  }
}