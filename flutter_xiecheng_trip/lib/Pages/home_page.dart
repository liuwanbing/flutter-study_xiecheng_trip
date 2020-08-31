import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterxiechengtrip/Dao/home_dao.dart';
import 'package:flutterxiechengtrip/Model/grid_nav_model.dart';
import 'dart:convert';

import 'package:flutterxiechengtrip/Model/home_model.dart';
import 'package:flutterxiechengtrip/Model/local_navlist_model.dart';
import 'package:flutterxiechengtrip/Model/sales_box_model.dart';
import 'package:flutterxiechengtrip/Widget/grid_nav.dart';
import 'package:flutterxiechengtrip/Widget/loading_container.dart';
import 'package:flutterxiechengtrip/Widget/local_nav.dart';
import 'package:flutterxiechengtrip/Widget/sales_box.dart';
import 'package:flutterxiechengtrip/Widget/sub_nav.dart';
import 'package:flutterxiechengtrip/Widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;//滑动最大高度，超出部分直接设置全透明

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();

}

class _HomePage extends State<HomePage>{
//  List _imageUrls = [
//    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
//    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
//    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
//  ];

  double appBarAlpha = 0;
  String resultString = "";
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  initState(){
    super.initState();
    _handleRefresh();
  }

  _onScroll(offset) {
    print(offset);
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
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
  Future<Null> _handleRefresh() async{
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
      });

    }catch (e){
      _loading = false;
      print(e);
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2fa),
      body: LoadingContainer(isLoading:_loading,child: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              //监听listView滚动 NotificationListener
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification){
                    if(notification is ScrollUpdateNotification && notification.depth == 0){
                      _onScroll(notification.metrics.pixels);
                    }
                    return true;
                  },
                  child: _listView(),
                ),
              )
          ),
          _appBar(),
        ],
      ),)

    );
  }

  Widget _listView(){
    return ListView(
      children: <Widget>[
        //轮播图
        _banner(),
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
        //酒店 机票，旅行
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child:  SubNav(subNavList: subNavList,),
        ),
        //更多福利
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child:  SalesBox(salesBox: salesBoxModel,),
        ),
      ],
    );
  }

 Widget _banner(){
    return Container(
      height: 160,
      child: Swiper(
        onTap: (index){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              WebView(url: bannerList[index].url,statusBarColor: bannerList[index].statusBarColor,hideAppBar: bannerList[index].hideAppBar,title: bannerList[index].title,)
          ));
        },
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            bannerList[index].icon,
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(), //指示器
      ),
    );
  }

  Widget _appBar(){
    //改变透明
    return Opacity(
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
    );
  }
}