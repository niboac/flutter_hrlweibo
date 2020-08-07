import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hrlweibo/pages/find_page.dart';
import 'package:flutter_hrlweibo/public.dart';

import 'home_page.dart';
import 'mine_page.dart';
import '../widget/iconfont.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '发现', '我'];
  var currentPage;
  DateTime lastPopTime;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  getTabImage(path) {
    return ImageIcon(
      AssetImage(path),
      size: 25,
    );
  }

  void initData() {
    tabImages = [
      [
        Icon(IconFont.icon_home),
        Icon(IconFont.icon_home2),
      ],
      [
        Icon(IconFont.icon_quanzi),
        Icon(IconFont.icon_quanzi2),
      ],
      [
        Icon(IconFont.icon_user),
        Icon(IconFont.icon_youxi),
      ],
    ];
  }

  final List<Widget> tabBodies = [HomePage(), FindPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    initData();
    final List<BottomNavigationBarItem> bottomTabs = [
      BottomNavigationBarItem(
          icon: getTabIcon(0), title: Text(appBarTitles[0])),
      BottomNavigationBarItem(
          icon: getTabIcon(1), title: Text(appBarTitles[1])),
      BottomNavigationBarItem(
          icon: getTabIcon(2), title: Text(appBarTitles[2])),
    ];

    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _tabIndex,
            items: bottomTabs,
            selectedItemColor: Color(0xff6688ff),
            selectedLabelStyle: TextStyle(color: Color(0xff6688ff)),
            selectedFontSize: 10,
            unselectedFontSize: 10,
            onTap: (index) async {
              setState(() {
                _tabIndex = index;
                currentPage = tabBodies[_tabIndex];
              });
            },
          ),
          body: IndexedStack(
            index: _tabIndex,
            children: tabBodies,
          ),
        ),
        onWillPop: () {
          // 点击返回键的操作
          if (lastPopTime == null ||
              DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            ToastUtil.show('再按一次退出应用');
          } else {
            lastPopTime = DateTime.now();
            // 退出app
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
      ),
    );
  }
}
