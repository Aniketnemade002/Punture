import 'package:fpdart/fpdart.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class UserRepoo {
  Future<Either<Fail, bool>> PasswordReset({required String email});
  Future<void> OwnrSaveFcmTocken({required String token});
  Future<void> UserSaveFcmTocken({required String token});
}
