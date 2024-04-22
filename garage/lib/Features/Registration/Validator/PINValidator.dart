import 'package:formz/formz.dart';

enum PINValidationError { empty, invalidFormat, mismatch }

class PIN extends FormzInput<String, PINValidationError> {
  const PIN.pure() : super.pure('');
  const PIN.dirty([String value = '']) : super.dirty(value);

  static final _pinRegExp = RegExp(r'^\d{4}$');

  @override
  PINValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PINValidationError.empty;
    } else if (!_pinRegExp.hasMatch(value)) {
      return PINValidationError.invalidFormat;
    }
    return null;
  }
}

class ConfirmPIN extends FormzInput<String, PINValidationError> {
  final String originalPIN;

  const ConfirmPIN.pure({this.originalPIN = ''}) : super.pure('');
  const ConfirmPIN.dirty({this.originalPIN = '', String value = ''})
      : super.dirty(value);

  static final _pinRegExp = RegExp(r'^\d{4}$');

  @override
  PINValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PINValidationError.empty;
    } else if (value.length != 4 || !_pinRegExp.hasMatch(value)) {
      return PINValidationError.invalidFormat;
    } else if (value != originalPIN) {
      return PINValidationError.mismatch;
    }
    return null;
  }
}
