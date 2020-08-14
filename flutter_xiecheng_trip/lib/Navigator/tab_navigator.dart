import 'package:flutter/material.dart';
import 'package:flutterxiechengtrip/Pages/home_page.dart';
import 'package:flutterxiechengtrip/Pages/my_page.dart';
import 'package:flutterxiechengtrip/Pages/search_page.dart';
import 'package:flutterxiechengtrip/Pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();

}

class _TabNavigatorState extends State<TabNavigator>{

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {

    final  _controller = PageController(
      initialPage: 0,
    );
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,//控制title不选中时候也显示文字
          onTap: (index){
            //跳转到对应的page
            _controller.jumpToPage(index);
            //点击后更新index
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(

                icon: Icon(Icons.home, color: _defaultColor,),
                title: Text('首页', style: TextStyle(
                    color: _currentIndex == 0 ? _activeColor : _defaultColor),),
                activeIcon: Icon(Icons.home, color: _activeColor,)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: _defaultColor,),
                title: Text('搜索', style: TextStyle(
                    color: _currentIndex == 1 ? _activeColor : _defaultColor),),
                activeIcon: Icon(Icons.search, color: _activeColor,)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera, color: _defaultColor,),
                title: Text('旅拍', style: TextStyle(
                    color: _currentIndex == 2 ? _activeColor : _defaultColor),),
                activeIcon: Icon(Icons.camera, color: _activeColor,)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: _defaultColor,),
                title: Text('我的', style: TextStyle(
                    color: _currentIndex == 3 ? _activeColor : _defaultColor),),
                activeIcon: Icon(Icons.person, color: _activeColor,)
            )
          ]
      ),
    );
  }


  _bottomNavigationBarItem(String title,int currentIndex){
   return BottomNavigationBarItem(
        icon: Icon(Icons.home, color: _defaultColor,),
        title: Text(title, style: TextStyle(
            color: currentIndex == 0 ? _activeColor : _defaultColor),),
        activeIcon: Icon(Icons.home, color: _activeColor,)
    );
  }
}