import 'package:flutter/material.dart';

class IconAnimate extends StatefulWidget {
  _IconAnimateState createState() => new _IconAnimateState();
  Widget child;
  IconAnimate(this.child);
}

class _IconAnimateState extends State<IconAnimate>
    with TickerProviderStateMixin {
  Animation animation;
  Animation _animation;
  AnimationController controller;
  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.ease);
    animation = new Tween(begin: 0.1, end: 0.99).animate(curve);
    _animation = Tween(begin: .4, end: .0).animate(curve);

    controller.forward();
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget _child) {
          return RotationTransition(
              turns: _animation,
              child: Opacity(opacity: animation.value, child: widget.child));
        });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
