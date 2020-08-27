import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterxiechengtrip/Dao/home_dao.dart';
import 'package:flutterxiechengtrip/Model/grid_nav_model.dart';
import 'dart:convert';

import 'package:flutterxiechengtrip/Model/home_model.dart';
import 'package:flutterxiechengtrip/Model/local_navlist_model.dart';
import 'package:flutterxiechengtrip/Widget/grid_nav.dart';
import 'package:flutterxiechengtrip/Widget/local_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;//滑动最大高度，超出部分直接设置全透明

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();

}

class _HomePage extends State<HomePage>{
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

  double appBarAlpha = 0;
  String resultString = "";
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;

  @override
  initState(){
    super.initState();
    loadData();
  }

  _onScroll(offset){
    print(offset);
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha<0){
      alpha = 0;
    }else  if(alpha>1){
      alpha =1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }


//  //两种写法，第一种
//  loadData(){
//    HomeDao.fetch().then((result){
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((error){
//      print('error==${error}');
//      setState(() {
//        resultString  = error.toString();
//       });
//    });
//
//  }

//  第二种
  loadData() async{
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
      });
    }catch (e){
      print(e);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2fa),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              removeTop: true,
              context: context,

              //监听listView滚动 NotificationListener
              child: NotificationListener<ScrollNotification>(

                onNotification: (ScrollNotification notification){
                  if(notification is ScrollUpdateNotification && notification.depth == 0){
                    _onScroll(notification.metrics.pixels);
                  }
                  return true;
                },
                child: ListView(
                  children: <Widget>[
                    //轮播图
                    Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(), //指示器
                      ),
                    ),
                    //球区
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child:Container(
                        child: LocalNav(localNavList: localNavList,),
                      ),
                    ),
                    //酒店 机票，旅行
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: GridNav(gridNavModel: gridNavModel,),
                    ),

                  ],
                ),

              )

          ),
          //改变透明
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
}