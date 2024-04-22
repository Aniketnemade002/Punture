import 'package:garage/Features/Registration/Validator/Address.dart';
import 'package:garage/Features/Registration/Validator/Email.dart';
import 'package:garage/Features/Registration/Validator/Location.dart';
import 'package:garage/Features/Registration/Validator/MobailNo.dart';
import 'package:garage/Features/Registration/Validator/Name.dart';
import 'package:garage/Features/Registration/Validator/PINValidator.dart';
import 'package:garage/Features/Registration/Validator/ServiceCost.dart';

class KError {
  static String? emailErrorText(EmailValidationError? error) {
    switch (error) {
      case EmailValidationError.empty:
        return 'Email cannot be empty';
      case EmailValidationError.invalidEmail:
        return 'Enter a valid email address';
      default:
        return null;
    }
  }

  static String? fullAddressErrorToString(FullAddressValidationError? error) {
    switch (error) {
      case FullAddressValidationError.empty:
        return 'Address cannot be empty';
      default:
        return null;
    }
  }

  static String? mobileErrorToString(MobileValidationError? error) {
    switch (error) {
      case MobileValidationError.empty:
        return 'Mobile number cannot be empty';
      case MobileValidationError.invalidFormat:
        return 'Invalid mobile number format';
      default:
        return null;
    }
  }

  static String? geoPointErrorToString(Position? error) {
    if (error == Position.empty) {
      return 'Please select a valid location';
    }
    return null;
  }

  static String? nameErrorToString(NameValidationError? error) {
    switch (error) {
      case NameValidationError.empty:
        return 'Name cannot be empty';
      default:
        return null;
    }
  }

  static String? garageNameErrorToString(GarageNameValidationError? error) {
    switch (error) {
      case GarageNameValidationError.empty:
        return 'Garage name cannot be empty';
      default:
        return null;
    }
  }

  static String? pinErrorToString(PINValidationError? error) {
    switch (error) {
      case PINValidationError.empty:
        return 'PIN cannot be empty';
      case PINValidationError.invalidFormat:
        return 'PIN must be a 4-digit number';

      default:
        return null;
    }
  }

  static String? confirmPinErrorToString(ConfirmPINValidationError? error) {
    switch (error) {
      case ConfirmPINValidationError.empty:
        return 'Confirm PIN cannot be empty';
      case ConfirmPINValidationError.mismatch:
        return 'PINs do not match';
      default:
        return null;
    }
  }

  static String? serviceCostErrorToString(ServiceCostValidationError? error) {
    switch (error) {
      case ServiceCostValidationError.empty:
        return 'Service cost cannot be empty';
      default:
        return null;
    }
  }
}
