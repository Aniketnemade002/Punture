// ignore_for_file: sort_child_properties_last

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/auth/Login/Prsentation/page/Login.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
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
  void initState() {
    isuser = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.secondary,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          centerTitle: true,
          title: Text("Welcome",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: fontstyles.Head,
                fontSize: 40,
                color: Kcolor.bg,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Kcolor.secondary,
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "________________ To Punture _______________",
                  style: TextStyle(
                    fontFamily: fontstyles.Head,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Kcolor.bg,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Please  ',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: fontstyles.Gpop,
                          color: Kcolor.bg,
                          fontWeight: FontWeight.w200),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Select Your',
                            style: TextStyle(
                                fontFamily: fontstyles.Gpop, color: Kcolor.bg)),
                        TextSpan(
                            text: ' Type!',
                            style: TextStyle(
                              color: Kcolor.bg,
                              fontWeight: FontWeight.w200,
                              fontFamily: fontstyles.Gpop,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Kcolor.bg,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside),
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

                                        print(_active);
                                        print(isuser);
                                      });
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
                        onPressed: () => safeOnPressed(
                          context,
                          () async {
                            await pref!.setString('UserEntity',
                                isuser == true ? 'user' : 'owner');
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
                                          builder: (context) => LoginScreen(),
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
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                          },
                        ),
                        child: const SizedBox(
                          height: 25,
                          width: 150,
                          child: Center(
                            child: Text("Select",
                                style: TextStyle(
                                    fontFamily: fontstyles.Gpop,
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
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
          const SizedBox(
            height: 15,
          ),
          const Text(
            "User",
            style: TextStyle(
                color: Colors.black,
                fontFamily: fontstyles.Gpop,
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
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Mechanic",
            style: TextStyle(
                color: Colors.black,
                fontFamily: fontstyles.Gpop,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          )
        ],
      )),
    );
  }
}
