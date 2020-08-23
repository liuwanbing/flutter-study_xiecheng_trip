import 'dart:async';
import 'dart:convert';
import 'package:flutterxiechengtrip/Model/home_model.dart';
import 'package:http/http.dart' as http;

const String HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async{
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200){
      //解决乱码问题
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      var resultJson = json.decode(utf8decoder.convert(response.bodyBytes));//解码返回json数据
      return HomeModel.fromJson(resultJson);
    }else {
      throw Exception('加载home_json请求错误❌');
    }
  }
}