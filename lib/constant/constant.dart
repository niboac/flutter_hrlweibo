import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

class Constant {
  //  static const baseUrl ='http://192.168.56.1:8080/hrlweibo/';
  static const baseUrl = 'http://212.64.95.5:8080/hrlweibo/';

  static const String ASSETS_IMG = 'assets/images/';

  static const bool ISDEBUG = false;

  static const String SP_USER = 'sp_user';

  static const String SP_KEYBOARD_HEGIHT = 'sp_keyboard_hegiht'; //软键盘高度

  static const int PAGE_SIZE = 10;

  static const COLOR_TITLE = Color(0xFF202020);
  static const COLOR_SUBTITLE = Color(0xFF88888A);
  static const COLOR_MUTE = Color(0xccccccff);
  static const COLOR_WARN = Color(0xFFF59A23);
  static const COLOR_ERROR = Color(0xFFFA3651);
  static const COLOR_PRIMARY = Color(0xFFA33028);
  static const COLOR_LINK = Color(0xCC61ADF3);

  static final EventBus eventBus = new EventBus();
}
