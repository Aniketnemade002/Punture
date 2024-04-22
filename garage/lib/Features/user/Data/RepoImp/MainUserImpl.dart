import 'package:fpdart/src/either.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';
import 'package:garage/Features/user/Data/Source/Remote_MainUser.dart';

import 'package:garage/Features/user/Domain/Repo/MainUserRepo.dart';
import 'package:garage/core/Error/Error.dart';

class MainUserRepoImpl implements MainUserRepo {
  mainUserDataSourceImpl _userDataSourceImpl = mainUserDataSourceImpl();
  @override
  Future<Either<Fail, MainUserModal?>> GetUser() async {
    try {
      final result = await _userDataSourceImpl.GetUser();
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}



// try {
//       final result =
//       return right(result);
//     } on Exp catch (e) {
//       return left(Fail(exp: e.massage));
//     }