import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List actions;

  MyAppBar({Key key, this.title, this.actions}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => getSize();
  Size getSize() {
    return new Size(100.0, 100.0);
  }
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffFAFAFA),
      leading: IconButton(
          iconSize: 30,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          }),
      title: Text(
        this.widget.title,
        style: TextStyle(fontSize: 16),
      ),
      elevation: 0.5,
      centerTitle: true,
      actions: this.widget.actions,
    );
  }
}
