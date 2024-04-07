import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garage/constant/constant.dart';
import 'package:lottie/lottie.dart';

class Optionscreen extends StatefulWidget {
  const Optionscreen({super.key});

  @override
  State<Optionscreen> createState() => _Optionscreen();
}

class _Optionscreen extends State<Optionscreen> {
  @override
  void initState() async {
    super.initState();
    final result = await pref!.getString('UserEntity');

    isuser = result == 'user' ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    // Define your custom colors
    Color backgroundColor = Kcolor.bg; // Background color of the screen
    Color textColor = Kcolor.TextB; // Text color
    Color buttonColor = Kcolor.button; // Background color of the buttons
    Color buttonTextColor = Kcolor.bg; // Text color of the buttons
    Color buttonBorderColor =
        Kcolor.desable; // Border color of the outlined button

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          SizedBox(
            child: Container(
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
                      child: isuser == true
                          ? Lottie.asset(
                              'assets/images/Animation/user/travell.json')
                          : Lottie.asset(
                              'assets/images/Animation/Garage/owner.json'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    isuser == true ? "Mechanic" : "Rider",
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppin',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  )
                ],
              )),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Text(
            'Some styled text here',
            style: TextStyle(fontSize: 18, color: textColor),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // isuser ==true? Login of user  : singinscreen of owner
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    side: BorderSide(color: buttonBorderColor),
                    backgroundColor: Colors.transparent,
                  ),
                  child:
                      Text('Log In', style: TextStyle(color: buttonTextColor)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // isuser ==true? singinscren of user  : singinscreen of owner
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child:
                      Text('Sign Up', style: TextStyle(color: buttonTextColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
