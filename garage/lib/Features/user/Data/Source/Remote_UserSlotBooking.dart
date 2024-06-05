import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
import 'package:garage/Features/user/Domain/Entity/UserModal.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:location/location.dart';

abstract interface class UserBookingRepoDataSourse {
  Future<List<FeatchGarageMoadlImpl>> GetGarages(String Village);
  Future<int> GetPin();
  Future<int> GetBalence();
  Future<bool> DoBookeSlot(
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
    GeoPoint CurrentLocation,
  );
}

class UserBookingRepoDataSourseImpl implements UserBookingRepoDataSourse {
  Location location = Location();

  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  Future<List<FeatchGarageMoadlImpl>> GetGarages(String Village) async {
    try {
      LocationData _locationData;
      _locationData = await location.getLocation();
      GeoPoint currentGeopoint =
          GeoPoint(_locationData.latitude!, _locationData.longitude!);
//
//
//
//
// /

      CollectionReference garages = _db.collection('OWNER');
      final querySnapshot =
          await garages.where('village', isEqualTo: Village).get();

      List<FeatchGarageMoadlImpl> Garages = [];
      for (var doc in querySnapshot.docs) {
        if (doc.exists) {
          Garages.add(FeatchGarageMoadlImpl.fromJson(doc));
        }
      }
      Garages.forEach((garage) => garage.currentGeopoint = currentGeopoint);

      return Garages;
    } catch (e) {
      print("peint ${e.toString()}");
      throw Exp(e);
    }
  }

  @override
  Future<int> GetPin() async {
    try {
      final _UID = await _fdb.currentUser!.uid;

      final Result = await _db.collection('USER').doc(_UID).get();

      if (Result.exists) {
        final data = Result['Pin'];

        return data;
      } else {
        return 1001;
      }
    } catch (e) {
      print(e);
      throw Exp(e);
    }
  }

  @override
  Future<int> GetBalence() async {
    try {
      final _UID = await _fdb.currentUser!.uid;

      final Result = await _db.collection('USER').doc(_UID).get();

      if (Result.exists) {
        final data = Result['Wallet'];

        return data;
      } else {
        return 1001;
      }
    } catch (e) {
      print(e);
      throw Exp(e);
    }
  }

  @override
  Future<bool> DoBookeSlot(
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
          _db.collection('OWNER').doc(owneruid).collection('BOOKING');

      final CollectionReference SlotRef =
          _db.collection('OWNER').doc(owneruid).collection('SLOTS');

      final DocumentReference newOwnerRefUser = OwnerRefUser.doc();
      final BookingID = newOwnerRefUser.id;

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
        'BookingId': BookingID,
      };

      OwnerRefUser.doc(BookingID).set(_DATA, SetOptions(merge: true));

      final CollectionReference UserRefUser =
          _db.collection('USER').doc(useruid).collection('BOOKING');

      UserRefUser.doc(BookingID).set(_DATA, SetOptions(merge: true));

      final UserBalanceRef = await _db.collection('USER').doc(useruid).get();
      if (UserBalanceRef.exists) {
        final int UserBalance = UserBalanceRef['Wallet'];

        final final_UserBalanceRef = UserBalance - serviceCost;
        await _db
            .collection('USER')
            .doc(useruid)
            .set({'Wallet': final_UserBalanceRef}, SetOptions(merge: true));
      }

      final OwnerBalanceRef = await _db.collection('OWNER').doc(owneruid).get();
      if (UserBalanceRef.exists) {
        final int OwnerUserBalance = OwnerBalanceRef['Wallet'];

        final final_OwnerUserBalance = OwnerUserBalance + serviceCost;
        await _db
            .collection('OWNER')
            .doc(owneruid)
            .set({'Wallet': final_OwnerUserBalance}, SetOptions(merge: true));
        await _db.collection('OWNER').doc(owneruid).set(
            {'NoOfSlots': FieldValue.increment(-1)}, SetOptions(merge: true));
      }

      await SlotRef.doc(SlotID).delete();
      return true;
    } catch (e) {
      print(e);
      throw Exp(e);
    }
  }
}
