import 'package:formz/formz.dart';

enum ServiceCostValidationError { empty, notANumber }

class ServiceCost extends FormzInput<int?, ServiceCostValidationError> {
  const ServiceCost.pure() : super.pure(null);
  const ServiceCost.dirty([int? value]) : super.dirty(value);

  @override
  ServiceCostValidationError? validator(int? value) {
    if (value == null) {
      return ServiceCostValidationError.empty;
    }
    return null;
  }
}
