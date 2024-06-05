import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:fpdart/src/either.dart';
import 'package:garage/Features/owner/Data/Source/Remote_MainOwner.dart';
import 'package:garage/Features/owner/Domain/Repo/MainOwnerRepo.dart';
import 'package:garage/core/Error/Error.dart';

class SlotRepoImpl implements SlotRepo {
  SlotDataSource _slotDataSource = SlotDataSource();

  @override
  Future<Either<Fail, bool>> AddSlot(Timestamp LastTimeDate) async {
    try {
      await _slotDataSource.AddSlot(LastTimeDate);

      return right(true);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  @override
  Future<Either<Fail, Timestamp>> GetLastSlot() async {
    try {
      final _result = await _slotDataSource.GetLastSlot();

      return right(_result);
    } on Exp catch (e) {
      print(e.massage);
      return left(Fail(exp: e.massage));
    }
  }
}





    //   try {
    //     final result = await _dataSourceImpl.GetOwner();
    //     return right(result);
    //   } on Exp catch (e) {
    //     return left(Fail(exp: e.massage));
    //   }
    // }