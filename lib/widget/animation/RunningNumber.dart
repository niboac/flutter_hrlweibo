import 'package:flutter/material.dart';

class RunningNumber extends StatefulWidget {
  _RunningNumberState createState() => new _RunningNumberState();
  final double value;
  final style;
  final textAlign;
  RunningNumber({this.value, this.style, this.textAlign = TextAlign.center});
}

class _RunningNumberState extends State<RunningNumber>
    with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = new Tween(begin: 0.1, end: 1).animate(curve);

    controller.forward();
  }

  Widget build(BuildContext context) {
    print('我是动画' + animation.value.toString());

    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget _child) {
          return Opacity(
              opacity: animation.value,
              child: Text(
                (widget.value).toString(),
                textAlign: widget.textAlign,
                style: widget.style,
              ));
        });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
