import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MainUser {
  final String fcm;
  final String village;
  final int wallet;
  final bool isProfileCompleted;
  final String name;
  final String email;
  final int mobileNo;
  final GeoPoint geoLocation;
  final int pin;

  MainUser(
      {required this.fcm,
      required this.village,
      required this.wallet,
      required this.isProfileCompleted,
      required this.name,
      required this.email,
      required this.mobileNo,
      required this.geoLocation,
      required this.pin});
}
