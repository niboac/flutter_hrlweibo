import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';

class ShareQqBtn extends StatelessWidget {
  const ShareQqBtn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Image.asset(
            Constant.ASSETS_IMG + 'share_group_qq.png',
            width: 30.0,
            height: 30.0,
          )),
      onTap: () {},
    );
  }
}
