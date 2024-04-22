import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage/constant/constant.dart';

Future<void> safeOnPressed(BuildContext context, Function action) async {
  if (isinterneconnected == false) {
    Fluttertoast.cancel();
    // No internet connection
    Fluttertoast.showToast(
        msg: "No internet connection available.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    // Internet connection is available, execute the function
    action();
  }
}
