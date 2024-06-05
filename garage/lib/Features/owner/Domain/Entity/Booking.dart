// final String garge_name;
// final String garage_owner;
// final String Vehical_No;
// final int phoneno;
// final DateTime bookingtime;
// final String Discription;

// final garegeUid;
// final UserUid;

import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerBookingData {
  final String owneruid;
  final String BookingId;
  final String garageName;
  final String ownername;
  final int OwnerMobileNo;
  final int serviceCost;
  final GeoPoint? GarageLocation;
  final String Address;
  final Timestamp SlotTime;

  final String username;
  final String useruid;

  final String Discription;
  final String Vehical_No;
  final int userMobileNo;
  GeoPoint? CurrentLocation;

  OwnerBookingData(
      {required this.garageName,
      required this.serviceCost,
      required this.BookingId,
      required this.ownername,
      required this.username,
      required this.useruid,
      required this.owneruid,
      required this.OwnerMobileNo,
      required this.userMobileNo,
      required this.GarageLocation,
      required this.CurrentLocation,
      required this.Discription,
      required this.Vehical_No,
      required this.Address,
      required this.SlotTime});
}
