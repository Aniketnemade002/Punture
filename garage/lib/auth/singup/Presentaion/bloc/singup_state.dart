part of 'singup_bloc.dart';

final class SignupState extends Equatable {
  final Email email;
  final bool isValid;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzSubmissionStatus status;

  const SignupState({
    this.email = const Email.pure(),
    this.isValid = false,
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  SignupState copyWith({
    Email? email,
    bool? isValid,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzSubmissionStatus? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, isValid, password, confirmPassword, status];
}
