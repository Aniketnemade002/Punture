import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';
import 'package:garage/Features/user/Domain/Entity/UserModal.dart';

import 'package:garage/core/Error/Error.dart';

abstract interface class MainUserRepo {
  Future<Either<Fail, MainUserModal?>> GetUser();
}

abstract interface class UserBookingSystemRepo {
  Future<Either<Fail, List<FeatchGarageMoadlImpl>>> GetGarages(String Village);
  Future<Either<Fail, List<FeatchSlotImpl>?>> GetTimeSlots(String GarageUid);
  Future<Either<Fail, int>> GetPin();
  Future<Either<Fail, int>> GetBalence();

  Future<Either<Fail, bool>> DoBookeSlot({
    required String owneruid,
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
    required GeoPoint CurrentLocation,
  });
}

abstract interface class UserBookingsDataRepo {
  Future<Either<Fail, List<UserBookingDataModal>?>> GetBookings();
}

abstract interface class UserBookingHistoryRepo {
  Future<Either<Fail, List<UserHistoryModal>?>> GetHistory();
}
