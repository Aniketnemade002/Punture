import 'package:flutter/material.dart';
import 'package:garage/constant/constant.dart';

class fontstyles {
  static const String Gpop = 'Poppins';
  static const String Head = 'Head';
  static const String Normal = 'Normal';
}

class KText {
  TextStyle RedHeadline = TextStyle(
    fontFamily: fontstyles.Head,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Kcolor.primary,
    letterSpacing: 1.2,
  );

  TextStyle WhiteHeadline = TextStyle(
    fontFamily: fontstyles.Head,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Kcolor.bg,
    letterSpacing: 1.2,
  );

  TextStyle WalletHead = TextStyle(
    fontFamily: fontstyles.Head,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Kcolor.bg,
  );

  TextStyle normal = TextStyle(
    fontFamily: fontstyles.Normal,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Kcolor.Black,
    letterSpacing: 1.2,
  );

  TextStyle Discription = TextStyle(
    fontFamily: fontstyles.Normal,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Kcolor.TextB,
  );
}
