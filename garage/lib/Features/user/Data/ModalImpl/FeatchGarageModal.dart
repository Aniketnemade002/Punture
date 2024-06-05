import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage/Features/user/Domain/Entity/UserModal.dart';
import 'package:location/location.dart';

class FeatchGarageMoadlImpl extends FeatchGarageMoadl {
  FeatchGarageMoadlImpl(
      {required super.fcm,
      required super.UID,
      required super.village,
      required super.address,
      required super.serviceCost,
      required super.wallet,
      required super.isProfileCompleted,
      required super.ownerName,
      required super.garageName,
      required super.email,
      required super.mobileNo,
      required super.geoLocation,
      required super.pin,
      required super.SID,
      required super.lastSlotTime,
      required super.noOfSlots,
      super.currentGeopoint});

  factory FeatchGarageMoadlImpl.fromJson(DocumentSnapshot doc) {
    Map json = doc.data() as Map;
    return FeatchGarageMoadlImpl(
      fcm: json['FCM'] ?? '',
      UID: json['UID'] ?? '',
      village: json['Village'] ?? '',
      address: json['Address'] ?? '',
      serviceCost: json['ServiceCost'] ?? 0,
      wallet: json['Wallet'] ?? 0,
      isProfileCompleted: json['isProfileCompleted'] ?? false,
      ownerName: json['OwnerName'] ?? '',
      garageName: json['GarageName'] ?? '',
      email: json['Email'] ?? '',
      mobileNo: json['MobileNo'] ?? 0,
      geoLocation: json['GeoLocation'] ?? GeoPoint(0, 0),
      pin: json['Pin'] ?? 0,
      SID: json['SID'] ?? 0,
      lastSlotTime: json['LastSlotTime'] ?? Timestamp.now(),
      noOfSlots: json['NoOfSlots'] ?? 0,
    );
  }
}

class FeatchSlotImpl extends FeatchSlot {
  FeatchSlotImpl({required super.SlotID, required super.SlotTime});
  factory FeatchSlotImpl.fromJson(DocumentSnapshot doc) {
    Map json = doc.data() as Map;
    return FeatchSlotImpl(SlotID: json['SlotID'], SlotTime: json['SlotTime']);
  }
}
