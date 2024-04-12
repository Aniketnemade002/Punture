import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/EmailVerify/Presentaion/bloc/email_verify_bloc.dart';
import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/main.dart';

class VerificationScreen extends StatelessWidget {
  final AuthRepoImpl _authRepoImpl = AuthRepoImpl();

  VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await _authRepoImpl.Logout()
                .then((value) => RestartWidget.restartApp(context));
          },
        ),
      ),
      body: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          if (state is VerificationInitial) {
            _authRepoImpl.SendVerificationEmail();
          } else if (state is VerificationVerified) {
            RestartWidget.restartApp(
                context); // Assuming you handle the restart correctly
          }
        },
        builder: (context, state) {
          if (state is VerificationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is VerificationNotVerified) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Please verify your email address."),
                  ElevatedButton(
                    child: Text("Resend Email"),
                    onPressed: state.canResendEmail
                        ? () async {
                            await _authRepoImpl.SendVerificationEmail();
                            context
                                .read<VerificationBloc>()
                                .add(EmailVerifyEvent.resendEmail);
                          }
                        : null,
                  ),
                ],
              ),
            );
          } else if (state is VerificationVerified) {
            return Center(child: Text("Email is verified!"));
          }
          return Container(); // Fallback empty container.
        },
      ),
    );
  }
}
