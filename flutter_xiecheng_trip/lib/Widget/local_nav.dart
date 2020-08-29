
import 'package:flutter/material.dart';
import 'package:flutterxiechengtrip/Model/grid_nav_model.dart';
import 'package:flutterxiechengtrip/Model/local_navlist_model.dart';
import 'package:flutterxiechengtrip/Widget/webview.dart';

class LocalNav extends StatelessWidget {

  final List<CommonModel> localNavList;

  //@required表示参数是必须的
  const LocalNav({Key key,@required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(padding: EdgeInsets.all(7),
        child: _items(context),
      ),

    );
  }

  _items(BuildContext context) {
    if(localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model){
      items.add(_item(context,model));
    });

    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween ,//排列方式
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
          WebView(url: model.url,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
        ));
        print("点击跳转");
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            height: 32,
            width: 32,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(model.title),
          ),
        ],
      ),
    );
  }
}