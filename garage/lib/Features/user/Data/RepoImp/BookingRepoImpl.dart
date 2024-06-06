import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:fpdart/src/either.dart';
import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
import 'package:garage/Features/user/Data/Source/Remote_MainUser.dart';
import 'package:garage/Features/user/Data/Source/Remote_UserBookings.dart';
import 'package:garage/Features/user/Data/Source/Remote_UserSlotBooking.dart';
import 'package:garage/Features/user/Domain/Entity/UserModal.dart';
import 'package:garage/Features/user/Domain/Repo/MainUserRepo.dart';
import 'package:garage/core/Error/Error.dart';

class BookingSystemRepoImpl implements UserBookingSystemRepo {
  UserBookingRepoDataSourseImpl _userBookingRepoDataSourseImpl =
      UserBookingRepoDataSourseImpl();
  UserBookingDataSourseImpl _userDataSourceImpl = UserBookingDataSourseImpl();

  Future<Either<Fail, List<FeatchGarageMoadlImpl>?>> GetGarages(
      String Village) async {
    try {
      final result = await _userBookingRepoDataSourseImpl.GetGarages(Village);
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  @override
  Future<Either<Fail, int>> GetPin() {
    // TODO: implement GetPin
    throw UnimplementedError();
  }

  @override
  Future<Either<Fail, bool>> DoBookeSlot(
      {required String owneruid,
      required String garageName,
      required String ownername,
      required int OwnerMobileNo,
      required int serviceCost,
      required GeoPoint GarageLocation,
      required String Address,
      required Timestamp SlotTime,
      required String username,
      required String SlotID,
      required String useruid,
      required String Discription,
      required String Vehical_No,
      required int userMobileNo,
      required GeoPoint CurrentLocation}) async {
    try {
      final result = await _userBookingRepoDataSourseImpl.DoBookeSlot(
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
      return right(true);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  @override
  Future<Either<Fail, int>> GetBalence() async {
    try {
      final _result = await _userBookingRepoDataSourseImpl.GetBalence();
      return right(_result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  @override
  Future<Either<Fail, List<FeatchSlotImpl>?>> GetTimeSlots(
      String GarageUid) async {
    try {
      final _result = await _userDataSourceImpl.GetTimeSlots(GarageUid);
      return right(_result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}
