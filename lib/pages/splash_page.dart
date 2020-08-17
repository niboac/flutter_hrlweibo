import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/pages/mine/login_page.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/routers/routers.dart';
import 'package:flutter_hrlweibo/util/sp_util.dart';
import 'package:flutter_hrlweibo/util/user_util.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  SplashPageState createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  _initData() async {
    await SpUtil.getInstance();
    // Navigator.pop(context);
    Routes.navigateTo(
        context, UserUtil.isLogin() ? Routes.indexPage : Routes.loginPage,
        transition: TransitionType.inFromLeft);
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 100),
              child: Image.asset(
                Constant.ASSETS_IMG + 'welcome-slogan.jpg',
                width: 200.0,
                height: 100.0,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 200),
              child: Image.asset(
                Constant.ASSETS_IMG + 'welcome-logo.png',
                width: 100.0,
                height: 100.0,
              ),
            ),
          ],
        ));
  }
}
