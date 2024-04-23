import 'package:formz/formz.dart';

enum AmountValidationError { empty, invalid }

class AmountInput extends FormzInput<int, AmountValidationError> {
  const AmountInput.pure() : super.pure(0);
  const AmountInput.dirty([int value = 0]) : super.dirty(value);

  @override
  AmountValidationError? validator(int? value) {
    if (value == null || value == 0) {
      return AmountValidationError.empty;
    } else if (value < 200) {
      return AmountValidationError.invalid;
    }
    return null;
  }
}
