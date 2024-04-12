import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';
import 'package:garage/EmailVerify/page/VerifyPage.dart';
import 'package:garage/auth/singup/Presentaion/bloc/singup_bloc.dart';
import 'package:garage/core/Validations/EmailValidator.dart';
import 'package:garage/core/Validations/PasswordValidator.dart';
import 'package:garage/main.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
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
              MaterialPageRoute(builder: (context) => VerificationScreen()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _EmailInput(),
              SizedBox(height: 8.0),
              _PasswordInput(),
              SizedBox(height: 8.0),
              _ConfirmPasswordInput(),
              SizedBox(height: 8.0),
              _SubmitButton(),
            ],
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
            errorText: state.email.isNotValid
                ? _emailErrorText(state.email.error)
                : null,
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
                onPressed: state.isValid
                    ? () {
                        FocusScope.of(context).unfocus();
                        context.read<SignupBloc>().add(SignupSubmitted());
                      }
                    : null,
                child: Text('Signup'),
              );
      },
    );
  }
}
