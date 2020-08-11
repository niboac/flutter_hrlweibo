import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/widget/MyAppBar.dart';

class FanPage extends StatefulWidget {
  @override
  _FanPageState createState() => _FanPageState();
}

class _FanPageState extends State<FanPage> {
  TabController mTabcontroller;
  ScrollController mListController = new ScrollController();
  List mRecommendList;

  @override
  void initState() {
    super.initState();
    mTabcontroller =
        TabController(vsync: ScrollableState(), initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: MyAppBar(
        title: '粉丝',
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 15),
              child: InkWell(
                child: Center(
                  child: Text('发现用户'),
                ),
                onTap: () {},
              )),
        ],
      ),
      body: Container(
        color: Color(0xffeeeeee),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: TabBar(
                tabs: [
                  Tab(
                    text: "推荐",
                  ),
                  Tab(
                    text: "粉丝",
                  ),
                ],
                controller: mTabcontroller,
                //配置控制器
                indicatorColor: Colors.deepOrange,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Color(0xff333333),
                labelStyle: TextStyle(
                  fontSize: 16.0,
                ),
                unselectedLabelColor: Color(0x99666666),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                controller: mTabcontroller, //配置控制器
                children: <Widget>[
                  FFRecommendPage(),
                  FanListPage(),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
