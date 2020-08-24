class CommonModel {
  String icon = '';
  String title = '';
  String url = '';
  String statusBarColor = '';
  bool hideAppBar = false;

  CommonModel({
    this.icon,
    this.title,
    this.url,
    this.statusBarColor,
    this.hideAppBar,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json){
    CommonModel localNavList = CommonModel();
    localNavList.icon = json['icon'];
    localNavList.title = json['title'];
    localNavList.url = json['url'];
    localNavList.statusBarColor = json['statusBarColor'];
    localNavList.hideAppBar = json['hideAppBar'];
    return localNavList;
  }


  Map<String, dynamic> toJson(){
    return {
      "icon": icon,
      "title": title,
      "url": url,
      "statusBarColor": statusBarColor == null ? null : statusBarColor,
      "hideAppBar": hideAppBar,
    };
  }
}