import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Fresh.dart';
import 'package:garage/auth/Login/Prsentation/bloc/login_bloc.dart';
import 'package:garage/auth/singup/Presentaion/page/SingUp.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:formz/formz.dart';
import 'package:garage/auth/Login/Prsentation/page/Forgotpass.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/route_animation/index.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:garage/core/Validations/EmailValidator.dart';
import 'package:garage/core/Validations/PasswordValidator.dart';
import 'package:garage/main.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectScreen(), //owner
                    ),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.arrow_back_ios, color: Kcolor.bg)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(10, 20), // Rounded bottom edges
            ),
          ),
          title: Text("Login",
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please Loggin to enjoy all the great service we offer !",
                      style: TextStyle(
                        fontFamily: fontstyles.Head,
                        fontSize: 15,
                        color: Kcolor.bg,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Kcolor.secondary,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            scaffoldMessengerKey.currentState
                ?.hideCurrentSnackBar(); // Hide previous Snackbars
            scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                actionOverflowThreshold: 0.25,
                padding: EdgeInsets.all(0.5),
                backgroundColor: Color.fromARGB(255, 255, 17, 0),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login Failed ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.sms_failed,
                      color: Kcolor.bg,
                    )
                  ],
                ),
                duration: Duration(seconds: 2)));
          }
          if (state.status.isSuccess) {
            RestartWidget.restartApp(context);
          }
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height),
            alignment: Alignment.topCenter,
            color: Kcolor.secondary,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Kcolor.bg,
              ),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Card(
                shadowColor: Kcolor.secondary,
                elevation: 1,
                surfaceTintColor: Kcolor.bg,
                color: Kcolor.bg,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: isuser == true
                            ? Lottie.asset(
                                'assets/images/Animation/user/travell.json')
                            : Lottie.asset(
                                'assets/images/Animation/Garage/owner.json'),
                      ),
                      SizedBox(height: 20),
                      _EmailInput(),
                      SizedBox(height: 20),
                      _PasswordInput(),
                      SizedBox(height: 8),
                      _ForgotPasswordButton(),
                      SizedBox(height: 20),
                      _SubmitButton(),
                      SizedBox(height: 8),
                      _SingUpButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText:
                state.email.isNotValid ? 'Enter a valid email address' : null,
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        );
      },
    );
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
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.password.isNotValid
                ? _passwordErrorText(state.password.error)
                : null,
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
          ),
        );
      },
    );
  }

  String? _passwordErrorText(PasswordValidationError? error) {
    switch (error) {
      case PasswordValidationError.empty:
        return 'Password cannot be empty';
      case PasswordValidationError.invalid:
        return 'Password at least 5 char & 1 latter,1 !@#%,1 number ';
      default:
        return null;
    }
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      state.isValid ? Kcolor.Fbutton : Kcolor.TextB,
                  shadowColor: Kcolor.button,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onPressed: state.isValid
                    ? () => safeOnPressed(context, () {
                          FocusScope.of(context).unfocus();
                          context.read<LoginBloc>().add(LoginSubmitted());
                        })
                    : null,
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontFamily: fontstyles.Gpop,
                      color: state.isValid ? Kcolor.bg : Kcolor.C_Under_3),
                ),
              );
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          FocusScope.of(context).unfocus();

          Navigator.of(context).push(SlideRightRoute(page: ForgotPassScreen()));
        },
        child: Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}

class _SingUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          FocusScope.of(context).unfocus();

          Navigator.of(context).push(SlideRightRoute(page: SignupScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dont have an account yet ?  ',
                style: TextStyle(color: Colors.blue)),
            Text(' SignUp.',
                style: TextStyle(
                    backgroundColor: Kcolor.button,
                    fontSize: 15,
                    color: Kcolor.bg,
                    fontFamily: fontstyles.Gpop,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
