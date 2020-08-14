import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hrlweibo/public.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
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
    if (isTopRoute) {
      if (UserUtil.isLogin()) {
        FormData params = FormData.fromMap({
          'muserId': UserUtil.getUserInfo().id,
          'otheruserId': UserUtil.getUserInfo().id,
        });
        DioManager.getInstance().post(ServiceUrl.getUserInfo, params, (data) {
          UserUtil.saveUserInfo(data['data']);
          SchedulerBinding.instance
              .addPostFrameCallback((_) => setState(() {}));
        }, (error) {});
      }
    }
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
                  _buildMoreActions(),
                  _buildBottom(),
                ],
              )),
            ],
          )),
    );
  }

  Widget mHeadWidget() {
    var image = (UserUtil.getUserInfo() == null ||
            UserUtil.getUserInfo().headurl == null)
        ? AssetImage(Constant.ASSETS_IMG + 'ic_avatar_default.png')
        : NetworkImage(UserUtil.getUserInfo().headurl);
    return CircleAvatar(radius: 45, backgroundImage: image);
  }

  //我的信息
  Widget _buildMyInfo() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Material(
              //水波纹按压效果
              color: Colors.white,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.only(top: 12, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(left: 20, right: 15),
                          child: UserUtil.getUserInfo().isvertify == 0
                              ? mHeadWidget
                              : Stack(
                                  children: <Widget>[
                                    mHeadWidget(),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        child: Image.asset(
                                          (UserUtil.getUserInfo().isvertify ==
                                                  1)
                                              ? Constant.ASSETS_IMG +
                                                  'home_vertify.webp'
                                              : Constant.ASSETS_IMG +
                                                  'home_vertify2.webp',
                                          width: 16.0,
                                          height: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Text(UserUtil.getUserInfo().nick,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: UserUtil.getUserInfo()
                                                          .ismember ==
                                                      0
                                                  ? Colors.black
                                                  : Color(0xffF86119)))),
                                ),
                                Center(
                                  child: UserUtil.getUserInfo().ismember == 0
                                      ? new Container()
                                      : Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Image.asset(
                                            Constant.ASSETS_IMG +
                                                'home_memeber.webp',
                                            width: 15.0,
                                            height: 13.0,
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              (UserUtil.getUserInfo() == null ||
                                      UserUtil.getUserInfo().decs == null)
                                  ? ""
                                  : UserUtil.getUserInfo().decs,
                              style: TextStyle(
                                  letterSpacing: 0,
                                  color: Colors.grey,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Image.asset(
                                  Constant.ASSETS_IMG + 'icon_right_arrow.png',
                                  width: 15.0,
                                  height: 30.0,
                                ),
                              )))
                    ],
                  ),
                ),
                onTap: () {
                  Routes.navigateTo(context, Routes.personinfoPage, params: {
                    'userid': UserUtil.getUserInfo().id,
                  });
                },
              )),
          Container(
            height: 0.5,
            color: Color(0xffE2E2E2),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Material(
                  //水波纹按压效果
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            '15',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '动态',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
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
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            UserUtil.getUserInfo().followCount,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '关注',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      print("点击关注");
                      Routes.navigateTo(context, Routes.personMyFollowPage,
                          transition: TransitionType.fadeIn);
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
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            UserUtil.getUserInfo().fanCount,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '粉丝',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
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
        ],
      ),
    );
  }

  //更多功能
  Widget _buildMoreActions() {
    return Container(
        //padding: EdgeInsets.only(top: 10, bottom: 10),
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
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
                    //水波纹按压效果
                    color: Colors.white,
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
                    //水波纹按压效果
                    color: Colors.white,
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
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
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
                              Constant.ASSETS_IMG + "icon_mine_fannews.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '粉丝头条',
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
