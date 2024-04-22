import 'package:fpdart/src/either.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
import 'package:garage/Features/owner/Data/Source/Remote_MainOwner.dart';
import 'package:garage/Features/owner/Domain/Repo/MainOwnerRepo.dart';
import 'package:garage/core/Error/Error.dart';

class MainOwnerRepoImpl implements MainOwnerRepo {
  mainOwnerDataSourceImpl _dataSourceImpl = mainOwnerDataSourceImpl();
  @override
  Future<Either<Fail, MainOwnerModal?>> GetOwner() async {
    try {
      final result = await _dataSourceImpl.GetOwner();
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}
