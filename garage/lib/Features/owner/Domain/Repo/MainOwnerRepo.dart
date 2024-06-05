import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class MainOwnerRepo {
  Future<Either<Fail, MainOwnerModal?>> GetOwner();
}

abstract interface class BookingRepo {
  Future<Either<Fail, List<OwnerBookingModal>?>> GetBookings();
  Future<Either<Fail, List<OwnerHistoryModal>?>> GetHistory();
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
      required GeoPoint CurrentLocation});
}

abstract interface class SlotRepo {
  Future<Either<Fail, Timestamp?>> GetLastSlot();
  Future<Either<Fail, bool>> AddSlot(Timestamp LastTimeDate);
}
