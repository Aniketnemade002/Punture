import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class SignUpRepo {
  Future<Either<Fail, bool>> SingUp(
      {required String email, required String password});
}
