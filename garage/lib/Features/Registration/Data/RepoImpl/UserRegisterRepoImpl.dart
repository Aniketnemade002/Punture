import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:fpdart/src/either.dart';
import 'package:garage/Features/Registration/Data/Source/RegistrationDatasource.dart';

import 'package:garage/Features/Registration/Domain/repo/RegisterRepo.dart';
import 'package:garage/core/Error/Error.dart';

class UserRegisterRepoImpl implements UserRegisterRepo {
  UserRegisterDataSourceImpl _userRegisterDataSourceImp =
      UserRegisterDataSourceImpl();
  @override
  Future<Either<Fail, bool>> UserRegister(
      {required String fcm,
      required String village,
      required int wallet,
      required bool isProfileCompleted,
      required String name,
      required String email,
      required int mobileNo,
      required GeoPoint geoLocation,
      required int pin}) async {
    try {
      final result = await _userRegisterDataSourceImp.UserRegister(
          fcm: fcm,
          village: village,
          wallet: wallet,
          isProfileCompleted: isProfileCompleted,
          name: name,
          email: email,
          mobileNo: mobileNo,
          geoLocation: geoLocation,
          pin: pin);
      return right(result as bool);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}
