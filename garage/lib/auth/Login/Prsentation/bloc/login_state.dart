part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final Email email;
  final bool isValid;
  final Password password;
  final FormzSubmissionStatus status;

  const LoginState({
    this.email = const Email.pure(),
    this.isValid = false,
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  LoginState copyWith({
    Email? email,
    bool? isValid,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzSubmissionStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, isValid, password, status];
}
