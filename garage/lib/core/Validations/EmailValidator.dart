import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalidEmail }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    return value.toString().isNotEmpty == true
        ? (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)
            ? null
            : EmailValidationError.invalidEmail)
        : EmailValidationError.empty;
  }
}
