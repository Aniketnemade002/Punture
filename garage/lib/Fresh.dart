// ignore_for_file: sort_child_properties_last

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/login.dart';
import 'package:garage/constant/OnBording/onbording.dart';
import 'package:garage/constant/constant.dart';
import 'package:lottie/lottie.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SlectScreen();
}

class _SlectScreen extends State<StatefulWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _active = 0;

  final List<Widget> _pages = [
    const SelectUser(),
    const SelectGarage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Kcolor.bg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Please  ',
                          style: TextStyle(
                              fontSize: 40,
                              color: Kcolor.secondary,
                              fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Select Your',
                                style: TextStyle(color: Kcolor.secondary)),
                            TextSpan(
                                text: ' Type!',
                                style: TextStyle(
                                    color: Kcolor.Fbutton,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 0,
                        child: Icon(
                          Icons.arrow_left_outlined,
                          size: 80,
                          color: _active == 0 ? Kcolor.bg : Kcolor.secondary,
                        ),
                      ),
                      SizedBox(
                        child: FadeInLeft(
                          from: 30,
                          duration: const Duration(milliseconds: 700),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Kcolor.C_Under,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      blurStyle: BlurStyle.outer)
                                ],
                                border: Border.all(
                                    color: Kcolor.C_Under,
                                    width: 3,
                                    style: BorderStyle.solid,
                                    strokeAlign: BorderSide.strokeAlignOutside),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              height: 350,
                              width: 232,
                              child: Stack(children: [
                                PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      _active = page;
                                      isuser = _active == 0 ? true : false;
                                    });
                                    debugPrint(page.toString());
                                  },
                                  itemCount: _pages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _pages[index % _pages.length];
                                  },
                                )
                              ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                        child: Icon(
                          Icons.arrow_right_outlined,
                          size: 80,
                          color: _active == 1 ? Kcolor.bg : Kcolor.secondary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _pages
                        .map((item) => AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: _active == _pages.indexOf(item) ? 20 : 6,
                              height: 4,
                              margin: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  color: Kcolor.button,
                                  borderRadius: BorderRadius.circular(20.0)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FadeInRight(
                      from: 30,
                      duration: const Duration(milliseconds: 700),
                      child: ElevatedButton(
                        autofocus: true,
                        onPressed: () async {
                          await pref!.setString(
                              'UserEntity', isuser == true ? 'user' : 'owner');
                          isuser == true
                              ? pref?.getBool('FirstRun') ?? true
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const OnBordUser(),
                                      ),
                                    )
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Userlogin(),
                                      ),
                                    )
                              : await pref?.getBool('FirstRun') ?? true
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const onBordOwner(),
                                      ),
                                    )
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Userlogin(),
                                      ),
                                    );
                        },
                        child: const SizedBox(
                          height: 25,
                          width: 150,
                          child: Center(
                            child: Text("Select",
                                style: TextStyle(
                                    fontFamily: 'klang',
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5)),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Kcolor.button,
                            shadowColor: Kcolor.button,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            )),
                      ))
                ],
              ))),
    );
  }
}

class SelectUser extends StatelessWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 10,
      child: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 240,
              width: 230,
              child: Lottie.asset('assets/images/Animation/user/travell.json'),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "User",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'poppin',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          )
        ],
      )),
    );
  }
}

class SelectGarage extends StatelessWidget {
  const SelectGarage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 10,
      child: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 240,
              width: 230,
              child: Lottie.asset('assets/images/Animation/Garage/owner.json'),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Mechanic",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'poppin',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          )
        ],
      )),
    );
  }
}
