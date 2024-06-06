import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:location/location.dart';

abstract interface class UserBookingDataSourse {
  Future<List<UserBookingDataModal>?> GetBookings();
  Future<List<FeatchSlotImpl>?> GetTimeSlots(String GarageUid);

  Future<List<UserHistoryModal>?> GetHistory();
}

class UserBookingDataSourseImpl implements UserBookingDataSourse {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  Future<List<UserBookingDataModal>?> GetBookings() async {
    try {
      final _uid = await _fdb.currentUser!.uid;

// /
      print('+++++++++++++++++++ Booking Requested From Fire Store +++++++');

      CollectionReference _Bookings =
          _db.collection('USER').doc(_uid).collection('BOOKING');
      final querySnapshot = await _Bookings.get();

///////
      ///|
      ///
      ///
      ///

      List<UserBookingDataModal> BookingsList = [];

      if (querySnapshot.docs.isEmpty) {
        print('object+++++++++++++++++++=');
        return null;
      } else {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            print(doc.toString());
            BookingsList.add(UserBookingDataModal.fromJson(doc));
          }
        }

        BookingsList.forEach((garage) => garage.CurrentLocation = CurrentLOC);
        print('+++++++++++${BookingsList.length}');
        return BookingsList;
      }
    } catch (e) {
      print(e);
      throw Exp(e);
    }
  }

  @override
  Future<List<UserHistoryModal>?> GetHistory() async {
    try {
      final _uid = await _fdb.currentUser!.uid;

//
//
//
// /

      CollectionReference _Bookings = _db.collection('USER');
      final querySnapshot =
          await _Bookings.doc(_uid).collection('HISTORY').get();

//

      List<UserHistoryModal> HistoryList = [];
      if (querySnapshot.docs.isEmpty) {
        return null;
      } else {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            HistoryList.add(UserHistoryModal.fromJson(doc));
          }
        }

        HistoryList.forEach((garage) => garage.CurrentLocation = CurrentLOC);
        return HistoryList;
      }
    } catch (e) {
      print(e);
      throw Exp(e);
    }
  }

  @override
  Future<List<FeatchSlotImpl>?> GetTimeSlots(String GarageUid) async {
    try {
      final _uid = await _fdb.currentUser!.uid;

//
//
//
//
// /
      print('++++++++++++++++++++Fetting Slots++++++++++');
      CollectionReference _Bookings = _db.collection('OWNER');
      final querySnapshot =
          await _Bookings.doc(GarageUid).collection('SLOTS').get();

      List<FeatchSlotImpl> TimeSlotList = [];
      if (querySnapshot.docs.isEmpty) {
        return null;
      } else {
        for (var doc in querySnapshot.docs) {
          print('++++++++++++++++++++Feted Slots++++++++++ ${doc.data()}');
          if (doc.exists) {
            TimeSlotList.add(FeatchSlotImpl.fromJson(doc));
          }
        }

        return TimeSlotList;
      }
    } catch (e) {
      print(e);
      throw Exp(e);
    }
  }
}
