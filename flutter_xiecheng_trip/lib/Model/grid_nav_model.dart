import 'local_navlist_model.dart';

class GridNavModel {
  GridNavItem hotel;
  GridNavItem flight;
  GridNavItem travel;

  GridNavModel({
    this.hotel,
    this.flight,
    this.travel,
  });

  factory GridNavModel.fromJson(Map<String, dynamic> json) => GridNavModel(
    hotel: GridNavItem.fromJson(json["hotel"]),
    flight: GridNavItem.fromJson(json["flight"]),
    travel: GridNavItem.fromJson(json["travel"]),
  );

  Map<String, dynamic> toJson() => {
    "hotel": hotel.toJson(),
    "flight": flight.toJson(),
    "travel": travel.toJson(),
  };
}


class GridNavItem {
  String startColor;
  String endColor;
  CommonModel mainItem;
  CommonModel item1;
  CommonModel item2;
  CommonModel item3;
  CommonModel item4;

  GridNavItem({
    this.startColor,
    this.endColor,
    this.mainItem,
    this.item1,
    this.item2,
    this.item3,
    this.item4,
  });

  factory GridNavItem.fromJson(Map<String, dynamic> json) => GridNavItem(
    startColor: json["startColor"],
    endColor: json["endColor"],
    mainItem: CommonModel.fromJson(json["mainItem"]),
    item1: CommonModel.fromJson(json["item1"]),
    item2: CommonModel.fromJson(json["item2"]),
    item3: CommonModel.fromJson(json["item3"]),
    item4: CommonModel.fromJson(json["item4"]),
  );

  Map<String, dynamic> toJson() => {
    "startColor": startColor,
    "endColor": endColor,
    "mainItem": mainItem.toJson(),
    "item1": item1.toJson(),
    "item2": item2.toJson(),
    "item3": item3.toJson(),
    "item4": item4.toJson(),
  };
}




