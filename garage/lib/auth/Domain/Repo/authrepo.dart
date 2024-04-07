import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:garage/auth/Domain/Eintity/LoginResponse.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class AuthRepo {
  Future<Either<Fail, LoginResponse?>> Login(
      {required String email, required String password});
  Future<Either<Fail, bool>> islogedin();
  Future<void> Logout();
  Future<Either<Fail, bool>> SendVerificationEmail();
  Future<Either<Fail, bool>> RedSendVerificationEmail();
  Future<Either<Fail, bool>> isverified();
}
