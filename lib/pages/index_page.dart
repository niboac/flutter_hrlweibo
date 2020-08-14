import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hrlweibo/pages/find_page.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:lottie/lottie.dart';

import '../widget/iconfont.dart';
import 'home_page.dart';
import 'mine_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '发现', '我'];
  var currentPage;
  DateTime lastPopTime;

  final List<Widget> tabBodies = [HomePage(), FindPage(), MinePage()];

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomTabs = [
      BottomNavigationBarItem(
        icon: Icon(IconFont.icon_home),
        title: Text(appBarTitles[0]),
        activeIcon: Lottie.asset(
          'assets/lottie/star-smash.json',
          onLoaded: (composition) {
            _controller.duration = composition.duration;
            _controller.animateTo(10);
          },
          width: 20,
          height: 25,
          repeat: false,
          fit: BoxFit.fill,
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(IconFont.icon_quanzi),
        title: Text(appBarTitles[1]),
        activeIcon: Icon(IconFont.icon_quanzi2),
      ),
      BottomNavigationBarItem(
        icon: Icon(IconFont.icon_user),
        title: Text(appBarTitles[2]),
        activeIcon: Icon(IconFont.icon_youxi),
      ),
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
