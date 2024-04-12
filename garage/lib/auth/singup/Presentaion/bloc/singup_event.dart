part of 'singup_bloc.dart';

@immutable
sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupEmailChanged extends SignupEvent {
  final String email;
  const SignupEmailChanged(this.email);
}

class SignupPasswordChanged extends SignupEvent {
  final String password;
  const SignupPasswordChanged(this.password);
}

class SignupConfirmPasswordChanged extends SignupEvent {
  final String password;
  const SignupConfirmPasswordChanged(this.password);
}

class SignupSubmitted extends SignupEvent {}
