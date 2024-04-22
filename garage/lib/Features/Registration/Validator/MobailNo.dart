import 'package:formz/formz.dart';

enum MobileValidationError { empty, invalidFormat }

class MobileNumber extends FormzInput<int?, MobileValidationError> {
  const MobileNumber.pure() : super.pure(null);
  const MobileNumber.dirty([int? value]) : super.dirty(value);

  static final _mobileRegExp = RegExp(r'^[0-9]{10}$');

  @override
  MobileValidationError? validator(int? value) {
    final stringValue = value?.toString() ?? '';
    if (stringValue.isEmpty) {
      return MobileValidationError.empty;
    } else if (!_mobileRegExp.hasMatch(stringValue)) {
      return MobileValidationError.invalidFormat;
    }
    return null;
  }
}
