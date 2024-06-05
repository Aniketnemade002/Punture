import 'package:flutter/material.dart';

class AppSplash extends StatefulWidget {
  const AppSplash({super.key});

  State<AppSplash> createState() => _AppSplashState();
}

class _AppSplashState extends State<AppSplash> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => LoginPage()));
    // });
  }

  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(85, 20, 85, 20),
          child: Center(
            child: Image.asset(
              'assets/images/logo/splash1.png',
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
