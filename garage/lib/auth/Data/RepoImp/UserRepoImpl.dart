import 'package:fpdart/fpdart.dart';
import 'package:garage/auth/Data/Source/Remote_User.dart';
import 'package:garage/auth/Domain/Repo/userrepo.dart';
import 'package:garage/core/Error/Error.dart';

class UserRepoImpl implements UserRepo {
  final UserDataSourceImpl user = UserDataSourceImpl();
  @override
  Future<Either<Fail, bool>> PasswordReset({required String email}) async {
    try {
      final result = await user.PasswordReset(email: email);
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e));
    }
  }

  @override
  Future<void> SaveFcmTocken({required String token}) async {
    try {
      await user.SaveFcmTocken(token: token);
    } on Exp catch (e) {
      Fail(exp: e);
    }
  }
}
