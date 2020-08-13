import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/widget/share/shareWechatBtn.dart';

class Share extends StatefulWidget {
  final WeiBoModel mModel;
  Share(BuildContext context, {Key key, this.mModel}) : super(key: key);
  @override
  _ShareState createState() => _ShareState(weiboData: mModel);
}

class _ShareState extends State<Share> {
  WeiBoModel weiboData;
  _ShareState({Key key, this.weiboData});
  @override
  Widget build(BuildContext context) {
    return _shareRow(context, weiboData);
  }
}

//分享布局
Widget _shareRow(BuildContext context, WeiBoModel weiboItem) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 0.0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('分享到'),
        ShareWechatBtn(title: '微信分享'),
        InkWell(
          onTap: () {},
          child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_wxfirend.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
        InkWell(
          onTap: () {},
          child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_qq.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
        InkWell(
          onTap: () {},
          child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_qqzone.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
        InkWell(
          onTap: () {},
          child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_long_pic.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
      ],
    ),
  );
}
