import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:fpdart/src/either.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
import 'package:garage/Features/owner/Data/Source/Remote_BookingDatasourse.dart';
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

class BookingRepoImpl implements BookingRepo {
  OwnerBooingDataSourseImpl _ownerBooingDataSourseImpl =
      OwnerBooingDataSourseImpl();
  @override
  Future<Either<Fail, List<OwnerBookingModal>?>> GetBookings() async {
    try {
      final result = await _ownerBooingDataSourseImpl.GetBookings();
      if (result == []) {
        return right(result);
      }

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  @override
  Future<Either<Fail, List<OwnerHistoryModal>?>> GetHistory() async {
    try {
      final result = await _ownerBooingDataSourseImpl.GetHistory();
      if (result == []) {
        return right(result);
      }

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  @override
  Future<Either<Fail, bool>> ReleasedAndDeleteSlot(
      {required String BookingId,
      required String owneruid,
      required String garageName,
      required String ownername,
      required int OwnerMobileNo,
      required int serviceCost,
      required GeoPoint GarageLocation,
      required String Address,
      required Timestamp SlotTime,
      required String SlotID,
      required String username,
      required String useruid,
      required String Discription,
      required String Vehical_No,
      required int userMobileNo,
      required GeoPoint CurrentLocation}) async {
    try {
      final result = await _ownerBooingDataSourseImpl.ReleasedAndDeleteSlot(
          BookingId,
          owneruid,
          garageName,
          ownername,
          OwnerMobileNo,
          serviceCost,
          GarageLocation,
          Address,
          SlotTime,
          SlotID,
          username,
          useruid,
          Discription,
          Vehical_No,
          userMobileNo,
          CurrentLocation);

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}
