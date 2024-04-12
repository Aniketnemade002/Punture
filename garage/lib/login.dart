import 'package:flutter/material.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/constant.dart ' as c;

class Userlogin extends StatefulWidget {
  const Userlogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Userlogin();
}

class _Userlogin extends State<Userlogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FloatingActionButton(
            child: Text("user"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Ownerlogin(),
                ),
              );
            }),
      ),
    );
  }
}

class Ownerlogin extends StatefulWidget {
  const Ownerlogin({super.key});

  @override
  State<StatefulWidget> createState() => _Ownerlogin();
}

class _Ownerlogin extends State<Ownerlogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FloatingActionButton(onPressed: () {
          scaffoldMessengerKey.currentState
              ?.showSnackBar(SnackBar(content: Text("this is owner")));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Userlogin(),
            ),
          );
        }),
      ),
    );
  }
}
