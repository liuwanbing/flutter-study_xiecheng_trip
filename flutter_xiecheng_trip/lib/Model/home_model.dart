import 'package:flutterxiechengtrip/Model/grid_nav_model.dart';
import 'grid_nav_model.dart';
import 'package:flutterxiechengtrip/Model/sales_box_model.dart';

import 'config_model.dart';
import 'local_navlist_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final  GridNavModel gridNav;
  final SalesBoxModel salesBox;
  HomeModel({this.config, this.bannerList, this.localNavList,this.subNavList, this.gridNav,this.salesBox});

  factory HomeModel.fromJson(Map<String,dynamic> json) {

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
        config: ConfigModel.fromJson(json),
        localNavList: localNavList,
        bannerList: bannerList,
        subNavList: subNavList,
        gridNav:GridNavModel.fromJson(json['gridNav']),
        salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );

  }


  Map<String,dynamic>toJson(){
    return{
      "config":config.toJson(),
      "bannerList": List<dynamic>.from(bannerList.map((v){return v.toJson();})),
      "localNavList":List<dynamic>.from(localNavList.map((v){return v.toJson();})),
      "subNavList":List<dynamic>.from(subNavList.map((v){return v.toJson();})),
      "gridNav":gridNav.toJson(),
      "salesBox":salesBox.toJson(),
    };
  }


}