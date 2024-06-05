import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage/Features/user/Domain/Entity/UserBookingModal.dart';

class UserBookingModal extends UserBookingData {
  UserBookingModal(
      {required super.garageName,
      required super.BookingId,
      required super.serviceCost,
      required super.ownername,
      required super.username,
      required super.useruid,
      required super.owneruid,
      required super.OwnerMobileNo,
      required super.userMobileNo,
      required super.GarageLocation,
      required super.CurrentLocation,
      required super.Discription,
      required super.Vehical_No,
      required super.Address,
      required super.SlotTime});

  factory UserBookingModal.fromJson(DocumentSnapshot doc) {
    Map json = doc.data() as Map;
    return UserBookingModal(
      garageName: json['garageName'] ?? '',
      ownername: json['ownername'] ?? '',
      username: json['username'] ?? '',
      useruid: json['useruid'] ?? '',
      BookingId: json['BookingId'] ?? '',
      owneruid: json['owneruid'] ?? '',
      Discription: json['Discription'] ?? '',
      Vehical_No: json['Vehical_No'] ?? '',
      Address: json['Address'] ?? '',
      userMobileNo: json['userMobileNo'] ?? 0,
      serviceCost: json['serviceCost'] ?? 0,
      OwnerMobileNo: json['OwnerMobileNo'] ?? 0,
      GarageLocation: json['GarageLocation'] ?? GeoPoint(0, 0),
      CurrentLocation: json['CurrentLocation'] ?? GeoPoint(0, 0),
      SlotTime: json['SlotTime'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'garageName': garageName,
      'ownername': ownername,
      'username': useruid,
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
  }
}

class UserBookingDataModal extends UserBookingData {
  UserBookingDataModal(
      {required super.garageName,
      required super.BookingId,
      required super.serviceCost,
      required super.ownername,
      required super.username,
      required super.useruid,
      required super.owneruid,
      required super.OwnerMobileNo,
      required super.userMobileNo,
      required super.GarageLocation,
      required super.CurrentLocation,
      required super.Discription,
      required super.Vehical_No,
      required super.Address,
      required super.SlotTime});

  factory UserBookingDataModal.fromJson(DocumentSnapshot doc) {
    Map json = doc.data() as Map;
    return UserBookingDataModal(
      garageName: json['garageName'] ?? '',
      ownername: json['ownername'] ?? '',
      username: json['username'] ?? '',
      useruid: json['useruid'] ?? '',
      BookingId: json['BookingId'] ?? '',
      owneruid: json['owneruid'] ?? '',
      Discription: json['Discription'] ?? '',
      Vehical_No: json['Vehical_No'] ?? '',
      Address: json['Address'] ?? '',
      userMobileNo: json['userMobileNo'] ?? 0,
      serviceCost: json['serviceCost'] ?? 0,
      OwnerMobileNo: json['OwnerMobileNo'] ?? 0,
      GarageLocation: json['GarageLocation'] ?? GeoPoint(0, 0),
      CurrentLocation: json['CurrentLocation'] ?? GeoPoint(0, 0),
      SlotTime: json['SlotTime'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
  }
}
