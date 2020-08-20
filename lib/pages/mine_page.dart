import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/widget/animation/IconAnimate.dart';
import 'package:flutter_hrlweibo/widget/animation/RunningNumber.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
    print('我的页面,init');
    if (UserUtil.isLogin()) {
      FormData params = FormData.fromMap({
        'muserId': UserUtil.getUserInfo().id,
        'otheruserId': UserUtil.getUserInfo().id,
      });
      DioManager.getInstance().post(ServiceUrl.getUserInfo, params, (data) {
        UserUtil.saveUserInfo(data['data']);
        setState(() {});
      }, (error) {});
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    var isTopRoute = ModalRoute.of(context).isCurrent;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Color(0xffEEEEEE),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  _buildMyInfo(),
                  _bindGame(),
                  _buildMoreActions(),
                  _buildBottom(),
                ],
              )),
            ],
          )),
    );
  }

  Widget _bindGame() {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xff3D3B47),
          height: 53,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 20, 15, 15),
          padding: EdgeInsets.all(10),
          decoration: Constant.BORDER_RADIUS_BOX,
          child: ListTile(
            title: Text('您有游戏需要绑定'),
            subtitle: Text('you jige youxi xuyao'),
            trailing: Container(
              height: 30,
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(15, 2, 15, 2),
                color: Constant.COLOR_PRIMARY,
                textColor: Colors.white,
                shape: StadiumBorder(),
                child: Text(
                  '立即绑定',
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget mHeadWidget() {
    var image = (UserUtil.getUserInfo() == null ||
            UserUtil.getUserInfo().headurl == null)
        ? AssetImage(Constant.ASSETS_IMG + 'ic_avatar_default.png')
        : NetworkImage(UserUtil.getUserInfo().headurl);
    return IconAnimate(CircleAvatar(radius: 55, backgroundImage: image));
  }

  //我的信息
  Widget _buildMyInfo() {
    return Container(
      color: Color(0xff3D3B47),
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(left: 20, right: 15),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: <Widget>[
                          mHeadWidget(),
                          UserUtil.getUserInfo().isvertify == 0
                              ? null
                              : Image.asset(
                                  (UserUtil.getUserInfo().isvertify == 1)
                                      ? Constant.ASSETS_IMG +
                                          'home_vertify.webp'
                                      : Constant.ASSETS_IMG +
                                          'home_vertify2.webp',
                                  width: 16.0,
                                  height: 16.0,
                                ),
                        ],
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(UserUtil.getUserInfo().nick,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text(
                        UserUtil.getUserInfo().decs ?? '',
                        style: TextStyle(
                            letterSpacing: 0, color: Colors.grey, fontSize: 14),
                      ).padding(top: 5)
                    ],
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            Constant.ASSETS_IMG + 'icon_right_arrow.png',
                            width: 15.0,
                            height: 30.0,
                          ).padding(right: 20)))
                ],
              ),
              onTap: () {
                Routes.navigateTo(context, Routes.personinfoPage, params: {
                  'userid': UserUtil.getUserInfo().id,
                });
              },
            ),
          ),
          Container(
            height: 35,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Column(
                    children: <Widget>[
                      RunningNumber(
                        1534,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '动态',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ).padding(bottom: 20),
                    ],
                  ),
                  onTap: () {
                    print("点击关注");
                  },
                ),
                flex: 1,
              ),
              Expanded(
                child: InkWell(
                  child: Column(
                    children: <Widget>[
                      RunningNumber(
                        int.parse(UserUtil.getUserInfo().followCount),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '关注',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ).padding(bottom: 20),
                    ],
                  ),
                  onTap: () {
                    print("点击关注");
                    Routes.navigateTo(context, Routes.personMyFollowPage,
                        transition: TransitionType.fadeIn);
                  },
                ),
                flex: 1,
              ),
              Expanded(
                child: InkWell(
                  child: Column(
                    children: <Widget>[
                      RunningNumber(
                        int.parse(UserUtil.getUserInfo().fanCount),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '粉丝',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ).padding(bottom: 20),
                    ],
                  ),
                  onTap: () {
                    Routes.navigateTo(context, Routes.personFanPage,
                        transition: TransitionType.fadeIn);
                  },
                ),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //更多功能
  Widget _buildMoreActions() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_pic.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '我的相册',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Routes.navigateTo(context, '${Routes.settingPage}');
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_zan.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '我的赞',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_fans.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '我的粉丝',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Routes.navigateTo(context, Routes.personFanPage,
                            transition: TransitionType.fadeIn);
                      },
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Image.asset(
                            Constant.ASSETS_IMG + "icon_mine_wallet.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text(
                            '钱包',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      print("点击关注");
                    },
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_gchoose.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '优选',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG +
                                  "icon_mine_customservice.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '客服中心',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ],
        ));
  }

  _buildBottom() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        Constant.ASSETS_IMG + "icon_mine_freenet.png",
                        width: 25,
                        height: 25,
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '设置',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ))),
                      Image.asset(
                        Constant.ASSETS_IMG + "icon_right_arrow.png",
                        width: 15,
                        height: 15,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Routes.navigateTo(context, '${Routes.settingPage}');
                },
              ),
            ),
            Container(
              height: 0.5,
              color: Color(0xffE2E2E2),
            ),
          ],
        ));
  }
}
