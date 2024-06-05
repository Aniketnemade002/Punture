import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Fresh.dart';
import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/auth/bloc/auth_bloc.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:garage/main.dart';
import 'package:lottie/lottie.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final AuthRepoImpl _authRepoImpl = AuthRepoImpl();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer? _timer;
  Timer? _resendTimer;
  bool _canResendEmail = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    sendVerificationEmail();
    checkEmailVerificationStatus();
  }

  void sendVerificationEmail() async {
    setState(() => _isLoading = true);
    await _authRepoImpl.SendVerificationEmail().then((_) {
      setState(() {
        _isLoading = false;
        _canResendEmail = false; // disable resend initially
      });
      startResendTimer();
    }).catchError((error) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send verification email: $error")));
    });
  }

  void onLogout() async {
    context.read<AuthBloc>().add(AuthenticationLogoutRequested());
    Future.delayed(Duration.zero, () async {
      print('Verification  Done  App ......$isuser ');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => const SelectScreen(),
        ),
        (Route route) => false,
      );
    });
  }

  void startResendTimer() {
    _resendTimer?.cancel();
    _resendTimer = Timer(const Duration(seconds: 20), () {
      setState(() => _canResendEmail = true);
    });
  }

  void checkEmailVerificationStatus() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _auth.currentUser!.reload();
      if (_auth.currentUser!.emailVerified) {
        timer.cancel();
        context.read<AuthBloc>().add(AuthenticationLogoutRequested());
        Future.delayed(Duration.zero, () async {
          print('User Verified Logged Out Done App ......$isuser ');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const SelectScreen(),
            ),
            (Route route) => false,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(190),
        child: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Kcolor.bg),
              onPressed: onLogout,
              tooltip: 'Logout',
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(100, 20), // Rounded bottom edges
            ),
          ),
          title: Text("Email Verification",
              style: TextStyle(
                fontFamily: fontstyles.Head,
                fontSize: 40,
                color: Kcolor.bg,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Kcolor.secondary,
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Check Your Email",
                  style: TextStyle(
                    fontFamily: fontstyles.Head,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Kcolor.bg,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "We have sent a verification link to your email address. Please check your email and click on the link to proceed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: fontstyles.Head,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 250,
              child: Lottie.asset('assets/images/Animation/loadingGaer.json'),
            ),
            Icon(Icons.email, size: 80, color: Kcolor.Fbutton),
            const SizedBox(height: 40),
            const Text(
              textAlign: TextAlign.center,
              "Please verify your email address to continue. The verification will be detected automatically.",
              style: TextStyle(fontFamily: fontstyles.Head, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _canResendEmail ? Kcolor.secondary : Kcolor.desable,
                shadowColor: Kcolor.secondary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
              onPressed: _canResendEmail
                  ? () => safeOnPressed(context, sendVerificationEmail)
                  : null,
              child: const SizedBox(
                height: 25,
                width: 150,
                child: Center(
                  child: Text(
                    "Resend Email",
                    style: TextStyle(
                        fontFamily: fontstyles.Normal,
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Center(
  //         child: Text(
  //           "Email Verification",
  //           style: TextStyle(
  //               fontSize: 30,
  //               fontWeight: FontWeight.w500,
  //               color: Kcolor.Fbutton),
  //         ),
  //       ),
  //       backgroundColor: Colors.transparent,
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Center(
  //             child: SizedBox(
  //               height: 250,
  //               width: 250,
  //               child: Lottie.asset('assets/images/Animation/loadingGaer.json'),
  //             ),
  //           ),
  //           Icon(Icons.email, size: 80, color: Kcolor.secondary),
  //           SizedBox(height: 40),
  //           Text(
  //             "Please verify your email address.",
  //             style: TextStyle(fontSize: 13),
  //           ),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //                 backgroundColor:
  //                     _canResendEmail ? Kcolor.Fbutton : Colors.grey,
  //                 shadowColor: Kcolor.button,
  //                 shape: const RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(7)),
  //                 )),
  //             onPressed: _canResendEmail
  //                 ? () {
  //                     sendVerificationEmail();
  //                   }
  //                 : null,
  //             child: const SizedBox(
  //               height: 25,
  //               width: 150,
  //               child: Center(
  //                 child: Text("Resend",
  //                     style: TextStyle(
  //                         fontFamily: 'klang',
  //                         color: Colors.white,
  //                         fontSize: 17,
  //                         fontWeight: FontWeight.bold,
  //                         letterSpacing: 1.5)),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );

  // }
}
