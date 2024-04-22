import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import 'package:garage/core/Error/Error.dart';

abstract interface class UserRegisterRepo {
  Future<Either<Fail, bool>> UserRegister({
    required String fcm,
    required String village,
    required int wallet,
    required bool isProfileCompleted,
    required String name,
    required String email,
    required int mobileNo,
    required GeoPoint geoLocation,
    required int pin,
  });
}

abstract interface class OwnerRegisterRepo {
  Future<Either<Fail, bool>> OwnerRegister({
    required String fcm,
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
    required int SID,
  });
}
