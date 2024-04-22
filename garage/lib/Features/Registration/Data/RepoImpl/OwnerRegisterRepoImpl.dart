import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/Features/Registration/Data/Source/RegistrationDatasource.dart';
import 'package:garage/Features/Registration/Domain/repo/RegisterRepo.dart';
import 'package:garage/core/Error/Error.dart';

class OwnerRegisterRepoImpl implements OwnerRegisterRepo {
  OwnerRegisterDataSourceImpl _ownerRegisterDataSourceImpl =
      OwnerRegisterDataSourceImpl();
  @override
  Future<Either<Fail, bool>> OwnerRegister(
      {required String fcm,
      required String village,
      required String Address,
      required int ServiceCost,
      required int wallet,
      required bool isProfileCompleted,
      required String OwnerName,
      required String GarageName,
      required String email,
      required int mobileNo,
      required GeoPoint geoLocation,
      required int pin,
      required int SID}) async {
    try {
      final result = await _ownerRegisterDataSourceImpl.OwnerRegister(
          fcm: fcm,
          village: village,
          Address: Address,
          ServiceCost: ServiceCost,
          wallet: wallet,
          isProfileCompleted: isProfileCompleted,
          OwnerName: OwnerName,
          GarageName: GarageName,
          email: email,
          mobileNo: mobileNo,
          geoLocation: geoLocation,
          pin: pin,
          SID: SID);
      return right(result as bool);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}



// async {s
//     try {
      

//       return right(result);
//     } on Exp catch (e) {
//       return left(Fail(exp: e.massage));
//     }
//   }