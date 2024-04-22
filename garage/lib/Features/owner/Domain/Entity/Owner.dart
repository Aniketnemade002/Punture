import 'package:cloud_firestore/cloud_firestore.dart';

class MainOwner {
  final String fcm;
  final String village;
  final int wallet;
  final bool isProfileCompleted;
  final String garageName;
  final int serviceCost;
  final String ownername;
  final String email;
  final int mobileNo;
  final GeoPoint geoLocation;
  final int pin;
  final String Address;
  final int SID;

  MainOwner(
      {required this.fcm,
      required this.village,
      required this.wallet,
      required this.isProfileCompleted,
      required this.garageName,
      required this.serviceCost,
      required this.ownername,
      required this.email,
      required this.mobileNo,
      required this.geoLocation,
      required this.pin,
      required this.Address,
      required this.SID});
}
