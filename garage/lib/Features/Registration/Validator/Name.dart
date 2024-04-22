import 'package:formz/formz.dart';

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    return value.trim().isNotEmpty ? null : NameValidationError.empty;
  }
}

enum GarageNameValidationError { empty }

class GarageName extends FormzInput<String, GarageNameValidationError> {
  const GarageName.pure() : super.pure('');
  const GarageName.dirty([String value = '']) : super.dirty(value);

  @override
  GarageNameValidationError? validator(String value) {
    return value.trim().isNotEmpty ? null : GarageNameValidationError.empty;
  }
}
