import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:garage/EmailVerify/VerifyPage.dart';
import 'package:garage/auth/singup/Presentaion/bloc/singup_bloc.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/route_animation/index.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:garage/core/Validations/EmailValidator.dart';
import 'package:garage/core/Validations/PasswordValidator.dart';
import 'package:garage/main.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Kcolor.bg)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(10, 20), // Rounded bottom edges
            ),
          ),
          title: Text("Welcome",
              textAlign: TextAlign.center,
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create Your New Account  ",
                      style: TextStyle(
                        fontFamily: fontstyles.Head,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Kcolor.bg,
                      ),
                    ),
                    Icon(
                      Icons.create,
                      color: Kcolor.bg,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0.5),
                  child: Text(
                    "Create an account to enjoy all the great service we offer. ",
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
      backgroundColor: Kcolor.secondary,
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            RestartWidget.restartApp(context);
          }
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('Signup Success')));

            Navigator.of(context).pushAndRemoveUntil(
              SlideLeftRoute(page: EmailVerificationScreen()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            surfaceTintColor: Kcolor.bg,
            color: Kcolor.bg_2,
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: isuser == true
                          ? Lottie.asset(
                              'assets/images/Animation/user/travell.json',
                              width: 150,
                              height: 250)
                          : Lottie.asset(
                              'assets/images/Animation/Garage/owner.json'),
                    ),
                    SizedBox(height: 20),
                    _EmailInput(),
                    SizedBox(height: 20),
                    _PasswordInput(),
                    SizedBox(height: 20),
                    _ConfirmPasswordInput(),
                    SizedBox(height: 20),
                    _SubmitButton(),
                  ],
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
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) =>
              context.read<SignupBloc>().add(SignupEmailChanged(email)),
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
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<SignupBloc>().add(SignupPasswordChanged(password)),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context
              .read<SignupBloc>()
              .add(SignupConfirmPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            errorText: state.confirmPassword.isNotValid
                ? 'Passwords do not match'
                : null,
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
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
                          context.read<SignupBloc>().add(SignupSubmitted());
                        })
                    : null,
                child: Text(
                  'Create',
                  style: TextStyle(
                      fontFamily: fontstyles.Gpop,
                      color: state.isValid ? Kcolor.bg : Kcolor.C_Under_3),
                ),
              );
      },
    );
  }
}
