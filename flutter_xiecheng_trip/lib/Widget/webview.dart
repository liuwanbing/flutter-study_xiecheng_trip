import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];


class WebView extends StatefulWidget {

  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView({this.url, this.statusBarColor, this.title, this.hideAppBar,
    this.backForbid  = false}){
    if (url != null && url.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      url = url.replaceAll("http://", 'https://');
    }
  }

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  final webViewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError>  _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //防止页面重新打开
    webViewReference.close();
    _onUrlChanged = webViewReference.onUrlChanged.listen((String url) {

    });
    _onStateChanged =
        webViewReference.onStateChanged.listen((WebViewStateChanged state) {
          switch (state.type) {
            case WebViewState.startLoad:

              if (_isToMain(state.url) && !exiting) {
                //如果禁止返回，刷新当前页面
                if (widget.backForbid) {
                  webViewReference.launch(widget.url);
                } else {
                  Navigator.pop(context);
                  exiting = true;
                }
              }
              break;
            default:
              break;
          }
        });

    _onHttpError =
        webViewReference.onHttpError.listen((WebViewHttpError error) {
          print(error);
        });
  }

  //判断url是否包含携程的url
  //
  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }



  @override
  void dispose() {
    // TODO: implement dispose
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    webViewReference.dispose();
    _onHttpError.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backgroundColor;
    if (statusBarColorStr == 'ffffff'){
      backgroundColor = Colors.black;
    }else {
      backgroundColor = Colors.white;
    }
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+statusBarColorStr)), backgroundColor),
          //webView撑满整个界面
          Expanded(
            child:WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              //加载之前设置布局
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Waiting...'),
                ),
              ),
            ) ,
          ),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor){
    if(widget.hideAppBar ?? false){
      return Container(
        color: backButtonColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      //让里面的元素撑满整个屏幕
      child: FractionallySizedBox(
        //宽度撑满
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            //返回按钮
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                  child:Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  )
              ),
            ),
            //标题
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(widget.title ?? "",
                  style: TextStyle(color: backButtonColor,fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _test(){
    return Container();
  }

}