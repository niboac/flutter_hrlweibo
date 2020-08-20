import 'package:flutter/material.dart';

class RunningNumber extends StatefulWidget {
  _RunningNumberState createState() => new _RunningNumberState();
  final int value;
  final style;
  final textAlign;
  RunningNumber(this.value, {this.style, this.textAlign = TextAlign.center});
}

class _RunningNumberState extends State<RunningNumber>
    with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = new Tween(begin: 0.5, end: 1).animate(curve);

    controller.forward();
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget _child) {
          return Text(
            (widget.value * animation.value).round().toString(),
            textAlign: widget.textAlign,
            style: widget.style,
          );
        });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
