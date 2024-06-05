import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
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
  Location location = Location();
  @override
  Future<List<UserBookingDataModal>?> GetBookings() async {
    try {
      final _uid = await _fdb.currentUser!.uid;

//
//
//
//
// /

      CollectionReference _Bookings =
          _db.collection('USER').doc(_uid).collection('BOOKINGS');
      final querySnapshot = await _Bookings.get();

///////
      ///|
      ///
      ///
      ///
      LocationData _locationData;
      _locationData = await location.getLocation();
      GeoPoint currentGeopoint =
          GeoPoint(_locationData.latitude!, _locationData.longitude!);

      List<UserBookingDataModal> BookingsList = [];
      if (querySnapshot.docs.isEmpty) {
        print('object+++++++++++++++++++=');
        return [];
      } else {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            BookingsList.add(UserBookingDataModal.fromJson(doc));
          }
        }

        BookingsList.forEach(
            (garage) => garage.CurrentLocation = currentGeopoint);
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

      LocationData _locationData;
      _locationData = await location.getLocation();
      GeoPoint currentGeopoint =
          GeoPoint(_locationData.latitude!, _locationData.longitude!);
//

      List<UserHistoryModal> HistoryList = [];
      if (querySnapshot.docs.isEmpty) {
        return HistoryList;
      } else {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            HistoryList.add(UserHistoryModal.fromJson(doc));
          }
        }

        HistoryList.forEach(
            (garage) => garage.CurrentLocation = currentGeopoint);
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

      CollectionReference _Bookings = _db.collection('OWNER');
      final querySnapshot =
          await _Bookings.doc(GarageUid).collection('SLOTS').get();

      List<FeatchSlotImpl> TimeSlotList = [];
      if (querySnapshot.docs.isEmpty) {
        return [];
      } else {
        for (var doc in querySnapshot.docs) {
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
