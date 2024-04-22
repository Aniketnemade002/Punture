import 'package:flutter/material.dart';
import 'package:garage/constant/constant.dart';

class UserDash extends StatefulWidget {
  const UserDash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Userlogin();
}

class _Userlogin extends State<UserDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FloatingActionButton(
          child: Text("user"),
          onPressed: () {
            print("okookoook");
            if (isinterneconnected == true) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text('Got ittt man ')));
            } else {}
          },
        ),
      ),
    );
  }
}
