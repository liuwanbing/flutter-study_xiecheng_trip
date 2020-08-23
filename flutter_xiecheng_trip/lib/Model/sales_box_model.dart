import 'common_model.dart';

class SalesBoxModel {
  final String icon;
  final String moreUrl;
  final CommonModel bigCard1;
  final CommonModel bigCard2;
  final CommonModel smallCard1;
  final CommonModel smallCard2;
  final CommonModel smallCard3;
  final CommonModel smallCard4;

  SalesBoxModel(
      {this.icon,
      this.moreUrl,
      this.bigCard1,
      this.bigCard2,
      this.smallCard1,
      this.smallCard2,
      this.smallCard3,
      this.smallCard4});

  factory SalesBoxModel.fromJson(Map<String, dynamic> json) {
    return SalesBoxModel(
      icon: json['icon'],
      moreUrl: json['moreUrl'],
      bigCard1: json['bigCard1'],
      bigCard2: json['bigCard2'],
      smallCard1: json['smallCard1'],
      smallCard2: json['smallCard2'],
      smallCard3: json['smallCard3'],
      smallCard4: json['smallCard4'],
    );
  }
  Map<dynamic,dynamic> toJson(){
    return {
      icon :icon,
      moreUrl:moreUrl,
      bigCard1:bigCard1,
      bigCard2:bigCard2,
      smallCard1:smallCard1,
      smallCard2:smallCard2,
      smallCard3:smallCard3,
      smallCard4:smallCard4,
    };
  }

}
