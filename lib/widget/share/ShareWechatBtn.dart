import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:fluwx/fluwx.dart';

class ShareWechatBtn extends StatelessWidget {
  final String title;
  final String imgUrl;

  const ShareWechatBtn({Key key, this.title, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Image.asset(
            Constant.ASSETS_IMG + 'share_group_wx.png',
            width: 30.0,
            height: 30.0,
          )),
      onTap: () {
        shareToWeChat(WeChatShareTextModel(title, scene: WeChatScene.SESSION));
      },
    );
  }
}
