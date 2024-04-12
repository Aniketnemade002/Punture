import 'package:fpdart/src/either.dart';
import 'package:garage/auth/Data/Source/Remote_Signup.dart';
import 'package:garage/auth/Domain/Repo/SignUpRepo.dart';
import 'package:garage/core/Error/Error.dart';

class SignUpRepoImpl implements SignUpRepo {
  SignUpDataSourceImpl _RemoteDataSource = SignUpDataSourceImpl();

  @override
  Future<Either<Fail, bool>> RedSendVerificationEmail() async {
    try {
      final result = await _RemoteDataSource.ReSendVerificationEmail();
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e));
    }
  }

  @override
  Future<Either<Fail, bool>> SendVerificationEmail() async {
    try {
      final result = await _RemoteDataSource.SendVerificationEmail();
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e));
    }
  }

  @override
  Future<Either<Fail, bool>> SingUp(
      {required String email, required String password}) async {
    try {
      final result =
          await _RemoteDataSource.SignUp(email: email, password: password);

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}
