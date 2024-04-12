part of 'email_verify_bloc.dart';

@immutable
sealed class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationNotVerified extends VerificationState {
  final bool canResendEmail;
  VerificationNotVerified({this.canResendEmail = false});
}

class VerificationVerified extends VerificationState {}
