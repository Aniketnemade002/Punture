import 'package:cloud_firestore/cloud_firestore.dart';

class MainUser {
  final String fcm;
  final String village;
  final String uid;
  final int wallet;
  final bool isProfileCompleted;
  final String name;
  final String email;
  final int mobileNo;
  final GeoPoint? geoLocation;
  final int pin;

  MainUser(
      {required this.fcm,
      required this.village,
      required this.wallet,
      required this.isProfileCompleted,
      required this.name,
      required this.uid,
      required this.email,
      required this.mobileNo,
      required this.geoLocation,
      required this.pin});
}

class FeatchGarageMoadl {
  final String fcm;
  final String UID;
  final String village;
  final String address;
  final int serviceCost;
  final int wallet;
  final bool isProfileCompleted;
  final String ownerName;
  final String garageName;
  final String email;
  final int mobileNo;
  final GeoPoint? geoLocation;
  final int pin;
  final int SID;
  final Timestamp lastSlotTime;
  final int noOfSlots;
  GeoPoint? currentGeopoint;

  FeatchGarageMoadl(
      {required this.fcm,
      required this.UID,
      required this.village,
      required this.address,
      required this.serviceCost,
      required this.wallet,
      required this.isProfileCompleted,
      required this.ownerName,
      required this.garageName,
      required this.email,
      required this.mobileNo,
      required this.geoLocation,
      required this.pin,
      required this.SID,
      required this.lastSlotTime,
      required this.noOfSlots,
      this.currentGeopoint});
}

class FeatchSlot {
  final String SlotID;
  final Timestamp SlotTime;

  FeatchSlot({required this.SlotID, required this.SlotTime});
}
