import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Constant {
  //  static const baseUrl ='http://192.168.56.1:8080/hrlweibo/';
  static const baseUrl = 'http://212.64.95.5:8080/hrlweibo/';

  static const String ASSETS_IMG = 'assets/images/';

  static const bool ISDEBUG = true;

  static const String SP_USER = 'sp_user';

  static const String SP_KEYBOARD_HEGIHT = 'sp_keyboard_hegiht'; //软键盘高度

  static const int PAGE_SIZE = 10;

  static const COLOR_TITLE = Color(0xFF202020);
  static const COLOR_SUBTITLE = Color(0xFF88888A);
  static const COLOR_MUTE = Color(0xccccccff);
  static const COLOR_WARN = Color(0xFFF59A23);
  static const COLOR_ERROR = Color(0xFFFA3651);
  static const COLOR_PRIMARY = Color(0xFFFC6061);
  static const COLOR_LINK = Color(0xff5091cA);
  static const COLOR_TOPIC = Color(0xff5081CA);

  static var BORDER_RADIUS_BOX = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: Color(0x55dddddd),
          offset: Offset(3.0, 3.0),
          blurRadius: 5.0,
          spreadRadius: 1.0)
    ],
  );

  static final EventBus eventBus = new EventBus();
}
