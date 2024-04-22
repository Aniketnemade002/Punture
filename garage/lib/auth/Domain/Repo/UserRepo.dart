import 'package:fpdart/fpdart.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class UserRepo {
  Future<Either<Fail, bool>> PasswordReset({required String email});
  Future<void> SaveFcmTocken({required String token});
}
