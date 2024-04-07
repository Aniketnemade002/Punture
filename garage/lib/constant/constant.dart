import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class Kcolor {
  static Color primary = hexToColor('#990011');
  static Color bg = hexToColor('#faf9f9');
  static Color Black = hexToColor('#1d1d1d');
  static Color TextB = hexToColor('#35383b');

  static Color secondary = hexToColor('#bd3d4a'); // use this for wallet
  static Color desable = hexToColor('#c7c5c5');
  static Color button = hexToColor('#cb4950');
  static Color Connected = hexToColor('#23b84b');
  static Color Disconnected = hexToColor('#959a9d');
  static Color C_Under = hexToColor('#c15756');

  static Color Fbutton = hexToColor('#c00c26');
  // #da2633 payment button
}

class Kfont {
  static String main = 'DM Serif Display';
  static String primary = 'poppin';
}

late bool? isuser;
late bool? isinterneconnected;
late SharedPreferences? pref;
late bool? GodMode;
late String? UserUid;

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
