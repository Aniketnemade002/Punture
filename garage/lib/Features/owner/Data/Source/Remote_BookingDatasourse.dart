import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:location/location.dart';

abstract interface class OwnerBookingDataSourse {
  Future<List<OwnerBookingModal>?> GetBookings();

  Future<List<OwnerHistoryModal>?> GetHistory();

  Future<bool> ReleasedAndDeleteSlot(
      String BookingId,
      String owneruid,
      String garageName,
      String ownername,
      int OwnerMobileNo,
      int serviceCost,
      GeoPoint GarageLocation,
      String Address,
      Timestamp SlotTime,
      String SlotID,
      String username,
      String useruid,
      String Discription,
      String Vehical_No,
      int userMobileNo,
      GeoPoint CurrentLocation);
}

class OwnerBooingDataSourseImpl implements OwnerBookingDataSourse {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  Location location = Location();
  @override
  Future<List<OwnerBookingModal>?> GetBookings() async {
    try {
      final _uid = await _fdb.currentUser!.uid;

//
//
//
//
// /

      CollectionReference _Bookings = _db.collection('OWNER');
      final querySnapshot =
          await _Bookings.doc(_uid).collection('BOKINGS').get();

      LocationData _locationData;
      _locationData = await location.getLocation();
      GeoPoint currentGeopoint =
          GeoPoint(_locationData.latitude!, _locationData.longitude!);

      List<OwnerBookingModal> BookingsList = [];
      if (querySnapshot.docs.isEmpty) {
        return [];
      } else {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            BookingsList.add(OwnerBookingModal.fromJson(doc));
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
  Future<List<OwnerHistoryModal>?> GetHistory() async {
    try {
      final _uid = await _fdb.currentUser!.uid;

//
//
//
//
// /

      CollectionReference _Bookings = _db.collection('OWNER');
      final querySnapshot =
          await _Bookings.doc(_uid).collection('HISTORY').get();

      LocationData _locationData;
      _locationData = await location.getLocation();
      GeoPoint currentGeopoint =
          GeoPoint(_locationData.latitude!, _locationData.longitude!);

      List<OwnerHistoryModal> HistoryList = [];
      if (querySnapshot.docs.isEmpty) {
        return [];
      } else {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            HistoryList.add(OwnerHistoryModal.fromJson(doc));
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
  Future<bool> ReleasedAndDeleteSlot(
      String BookingId,
      String owneruid,
      String garageName,
      String ownername,
      int OwnerMobileNo,
      int serviceCost,
      GeoPoint GarageLocation,
      String Address,
      Timestamp SlotTime,
      String SlotID,
      String username,
      String useruid,
      String Discription,
      String Vehical_No,
      int userMobileNo,
      GeoPoint CurrentLocation) async {
    try {
      final CollectionReference OwnerRefUser =
          _db.collection('OWNER').doc(owneruid).collection('HISTORY');

      final CollectionReference SlotRef =
          _db.collection('OWNER').doc(owneruid).collection('SLOTS');

      final DocumentReference newOwnerRefUser = OwnerRefUser.doc();
      final HistoryID = newOwnerRefUser.id;

      final Map<String, dynamic> _DATA = {
        'garageName': garageName,
        'ownername': ownername,
        'username': username,
        'useruid': useruid,
        'owneruid': owneruid,
        'Discription': Discription,
        'Vehical_No': Vehical_No,
        'Address': Address,
        'userMobileNo': userMobileNo,
        'serviceCost': serviceCost,
        'OwnerMobileNo': OwnerMobileNo,
        'GarageLocation': GarageLocation,
        'CurrentLocation': CurrentLocation,
        'SlotTime': SlotTime,
        'BookingId': BookingId,
      };

      OwnerRefUser.doc(HistoryID).set(_DATA, SetOptions(merge: true));

      final CollectionReference UserRefUser =
          _db.collection('USER').doc(useruid).collection('HISTORY');

      UserRefUser.doc(HistoryID).set(_DATA, SetOptions(merge: true));

      await _db
          .collection('USER')
          .doc(useruid)
          .collection('BOKINGS')
          .doc(BookingId)
          .delete();

      await _db
          .collection('OWNER')
          .doc(owneruid)
          .collection('BOKINGS')
          .doc(BookingId)
          .delete();

      return true;
    } catch (e) {
      print(e);
      throw Exp(e);
    }
  }
}
