import 'dart:async';
import 'dart:convert';
import 'package:flutterxiechengtrip/Model/home_model.dart';
import 'package:http/http.dart' as http;

//const  HOME_URL = "http://www.devio.org.io/flutter_app/json/home_page.json";
const  Home_URL='https://www.devio.org/io/flutter_app/json/home_page.json';



class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(Home_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));///解码转成json
      return HomeModel.fromJson(result);
    }else {
      throw Exception("加载首页数据失败");
    }
  }
}