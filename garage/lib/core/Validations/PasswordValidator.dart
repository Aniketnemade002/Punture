import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();

  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{5,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (!_passwordRegex.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}

enum ConfirmPasswordValidationError { mismatch }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({this.password = '', String value = ''})
      : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    return password == value ? null : ConfirmPasswordValidationError.mismatch;
  }
}
