import 'package:formz/formz.dart';

enum PINValidationError { empty, invalidFormat }

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

enum ConfirmPINValidationError { empty, mismatch }

class ConfirmPIN extends FormzInput<String, ConfirmPINValidationError> {
  final String originalPIN;

  const ConfirmPIN.pure({this.originalPIN = ''}) : super.pure('');
  const ConfirmPIN.dirty({this.originalPIN = '', String value = ''})
      : super.dirty(value);

  @override
  ConfirmPINValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return ConfirmPINValidationError.empty;
    } else if (value != originalPIN) {
      return ConfirmPINValidationError.mismatch;
    }
    return null;
  }
}
