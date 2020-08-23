import 'package:flutterxiechengtrip/Model/common_model.dart';
import 'package:flutterxiechengtrip/Model/grid_nav_model.dart';
import 'package:flutterxiechengtrip/Model/sales_box_model.dart';

import 'config_model.dart';

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

  Map<dynamic,dynamic> toJson(){
    return {
      config :config,
      localNavList:localNavList,
      bannerList:bannerList,
      subNavList:subNavList,
      gridNav:gridNav,
      salesBox:salesBox,
    };
  }


}