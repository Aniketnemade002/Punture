import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage/auth/Data/RepoImp/UserRepoImpl.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:garage/core/Validations/EmailValidator.dart';

class ForgotPassScreen extends StatefulWidget {
  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  UserRepoImpl _user = UserRepoImpl();

  final TextEditingController _emailController = TextEditingController();
  Email _email = Email.pure();
  bool _isSubmitted = false;

  void handleSubmit() async {
    if (_email.isValid) {
      setState(() {
        _isSubmitted = true;
      });
      final result =
          await _user.PasswordReset(email: _emailController.text.trim());
      result.fold((l) {
        Fluttertoast.cancel();
        Failure.handle(l.exp);
        Fluttertoast.showToast(
            msg: "Please enter a valid email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
          (r) => r == true
              ? Fluttertoast.showToast(
                      msg:
                          "Reset link sent to your email. Returning to login screen.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0)
                  .then((value) => Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(
                            context); // Navigate back to the previous screen
                      }))
              : Fluttertoast.showToast(
                  msg: "Cant Send Reset Email.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0));
    } else if (_email.isNotValid) {
      _isSubmitted = false;
      Fluttertoast.showToast(
          msg: "Please enter a valid email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  String? _emailErrorText(EmailValidationError? error) {
    switch (error) {
      case EmailValidationError.empty:
        return 'Email cannot be empty';
      case EmailValidationError.invalidEmail:
        return 'Enter a valid email address';
      default:
        return null;
    }
  }

  void _onEmailChanged(String value) {
    setState(() {
      _email = Email.dirty(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(190),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(100, 20),
            ),
          ),
          title: Text("Forgot Password",
              style: TextStyle(
                fontFamily: fontstyles.Head,
                fontSize: 40,
                color: Kcolor.bg,
                fontWeight: FontWeight.bold,
              )),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Kcolor.bg)),
          backgroundColor: Kcolor.secondary,
          flexibleSpace: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 15),
                  Text(
                    "Reset Password",
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
                      "Please enter your email address below to receive the reset link.",
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
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: _onEmailChanged,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                errorText:
                    _email.isNotValid ? _emailErrorText(_email.error) : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Kcolor.secondary,
                shadowColor: Kcolor.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
              ),
              onPressed: () => safeOnPressed(
                  context,
                  !_isSubmitted
                      ? handleSubmit
                      : () {
                          Fluttertoast.showToast(
                              msg: "Reset Link Is Already Submitted.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Kcolor.Connected,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }),
              child: const Text(
                'Submit',
                style:
                    TextStyle(fontFamily: fontstyles.Gpop, color: Colors.white),
              ),
            ),
            if (_isSubmitted)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Password reset link sent to your email.Returning to login screen.',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    );
  }
}
