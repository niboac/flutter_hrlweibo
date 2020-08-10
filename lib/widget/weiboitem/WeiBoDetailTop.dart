import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'WeiBoItem.dart';
import 'Share.dart';

class WeiBoDetailTopWidget extends StatefulWidget {
  final WeiBoModel mModel;
  WeiBoDetailTopWidget({Key key, this.mModel}) : super(key: key);
  @override
  _WeiBoDetailTopWidgetState createState() =>
      _WeiBoDetailTopWidgetState(weiboData: mModel);
}

class _WeiBoDetailTopWidgetState extends State<WeiBoDetailTopWidget> {
  WeiBoModel weiboData;
  _WeiBoDetailTopWidgetState({Key key, this.weiboData});
  @override
  Widget build(BuildContext context) {
    return _wholeItemWidget(context, weiboData);
  }
}

//整个item布局
Widget _wholeItemWidget(BuildContext context, WeiBoModel weiboItem) {
  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        WeiBoItemWidget(weiboItem, true),

        Share(context),
        new Container(
          margin: EdgeInsets.only(top: 15),
          height: 12,
          color: Color(0xffEFEFEF),
        ), //下划线
      ],
    ),
  );
}
