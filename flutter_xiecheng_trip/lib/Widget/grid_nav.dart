
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterxiechengtrip/Model/grid_nav_model.dart';
import 'package:flutterxiechengtrip/Model/local_navlist_model.dart';
import 'package:flutterxiechengtrip/Widget/webview.dart';

class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;

  //@required表示参数是必须的
  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //这样设置圆角无效果，因为上面的视图把下面的视图覆盖了，
//    return Container(
//      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//      child: Column(
//        children: _gridNavItems(context),
//      ),
//    );
  //PhysicalModel 用来设置圆角效果，
  return PhysicalModel(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(6),
    clipBehavior: Clip.antiAlias,//裁切
    child: Column(
      children: _gridNavItems(context),
    ),
  );
  }

  //返回三列数据
  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if (gridNavModel == null)return items;
    //酒店
    if(gridNavModel.hotel != null){
      items.add(_gridNavItem(context,gridNavModel.hotel,true));
    }
    //机票
    if(gridNavModel.flight != null){
      items.add(_gridNavItem(context,gridNavModel.flight,false));
    }
    //旅行
    if(gridNavModel.travel != null){
      items.add(_gridNavItem(context,gridNavModel.travel,false));
    }
    //返回一个weidget数组
    return items;
  }

  //代表一整行
  _gridNavItem(BuildContext context,GridNavItem gridNavItem,bool first){
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget>expandItems = [];
    //遍历widget数组， 用expand 来撑满整个widget
    items.forEach((item){
       expandItems.add(Expanded(child: item,flex: 1,));
    });
    //渐变颜色,线性渐变
    Color startColor = Color(int.parse('0xff'+gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff'+gridNavItem.endColor));

    return  Container(
      height: 88,
        margin: first?null:EdgeInsets.only(top: 3),
        //设置一个线性渐变
        decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(
            colors:[startColor,endColor],
          ),
        ),
      child: Row(children: expandItems,),
    );
  }

  //左边大widget
  _mainItem(BuildContext context,CommonModel commonModel){
    return _wrapGesture(context, Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Image.network(commonModel.icon,
          fit: BoxFit.contain,
          height: 88,
          width: 121,
          alignment: AlignmentDirectional.bottomEnd,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(commonModel.title,style: TextStyle(fontSize: 14,color: Colors.white),),
        ),
      ],
    ),commonModel);
  }

  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        ),
      ],
    );
  }

  _item(BuildContext context,CommonModel item,bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none,
          ),
        ),
        child: _wrapGesture(context,
            Center(
              child: Text(item.title,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,color: Colors.white),
                     ),
            ), item)
      ),
    );
  }

  //封装gestrue widget
  _wrapGesture(BuildContext context,Widget widget,CommonModel model){
    return GestureDetector(
        onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          WebView(url: model.url,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,title: model.title,)
      ));
    },
      child: widget,
    );
  }

}