import 'package:formz/formz.dart';

enum AddressValidationError { empty }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure() : super.pure('');
  const Address.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError? validator(String value) {
    return value.trim().isNotEmpty ? null : AddressValidationError.empty;
  }
}

enum FullAddressValidationError { empty }

class FullAddress extends FormzInput<String, FullAddressValidationError> {
  const FullAddress.pure() : super.pure('');
  const FullAddress.dirty([String value = '']) : super.dirty(value);

  @override
  FullAddressValidationError? validator(String value) {
    return value.trim().isNotEmpty ? null : FullAddressValidationError.empty;
  }
}
