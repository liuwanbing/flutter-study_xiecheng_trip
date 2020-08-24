import 'local_navlist_model.dart';

class SalesBoxModel {
  String icon;
  String moreUrl;
  CommonModel bigCard1;
  CommonModel bigCard2;
  CommonModel smallCard1;
  CommonModel smallCard2;
  CommonModel smallCard3;
  CommonModel smallCard4;

  SalesBoxModel({
    this.icon,
    this.moreUrl,
    this.bigCard1,
    this.bigCard2,
    this.smallCard1,
    this.smallCard2,
    this.smallCard3,
    this.smallCard4,
  });

  factory SalesBoxModel.fromJson(Map<String, dynamic> json) => SalesBoxModel(
    icon: json["icon"],
    moreUrl: json["moreUrl"],
    bigCard1: CommonModel.fromJson(json["bigCard1"]),
    bigCard2: CommonModel.fromJson(json["bigCard2"]),
    smallCard1: CommonModel.fromJson(json["smallCard1"]),
    smallCard2: CommonModel.fromJson(json["smallCard2"]),
    smallCard3: CommonModel.fromJson(json["smallCard3"]),
    smallCard4: CommonModel.fromJson(json["smallCard4"]),
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "moreUrl": moreUrl,
    "bigCard1": bigCard1.toJson(),
    "bigCard2": bigCard2.toJson(),
    "smallCard1": smallCard1.toJson(),
    "smallCard2": smallCard2.toJson(),
    "smallCard3": smallCard3.toJson(),
    "smallCard4": smallCard4.toJson(),
  };
}


