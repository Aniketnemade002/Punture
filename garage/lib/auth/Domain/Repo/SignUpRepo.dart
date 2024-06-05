import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class SignUpRepo {
  Future<Either<Fail, bool>> UserSingUp(
      {required String email, required String password});
  Future<Either<Fail, bool>> OwnerSingUp(
      {required String email, required String password});
}
