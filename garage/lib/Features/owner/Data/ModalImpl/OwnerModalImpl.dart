import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage/Features/owner/Domain/Entity/Owner.dart';

class MainOwnerModal extends MainOwner {
  MainOwnerModal(
      {required super.fcm,
      required super.village,
      required super.wallet,
      required super.isProfileCompleted,
      required super.garageName,
      required super.serviceCost,
      required super.ownername,
      required super.email,
      required super.mobileNo,
      required super.geoLocation,
      required super.pin,
      required super.Address,
      required super.SID,
      required super.LastSlotTime});

  factory MainOwnerModal.fromJson(Map<String, dynamic> json) {
    return MainOwnerModal(
      fcm: json['FCM'] ?? '',
      village: json['Village'] ?? '',
      Address: json['Address'] ?? '',
      serviceCost: json['ServiceCost'] ?? 0,
      wallet: json['Wallet'] ?? 0,
      isProfileCompleted: json['isProfileCompleted'] ?? false,
      ownername: json['OwnerName'] ?? '',
      garageName: json['GarageName'] ?? '',
      email: json['Email'] ?? '',
      mobileNo: json['MobileNo'] ?? 0,
      geoLocation: json['GeoLocation'] ?? GeoPoint(0, 0),
      pin: json['Pin'] ?? 0,
      SID: json['SID'] ?? 0,
      LastSlotTime: json['LastSlotTime'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FCM': fcm,
      'Village': village,
      'Address': Address,
      'ServiceCost': serviceCost,
      'Wallet': wallet,
      'isProfileCompleted': isProfileCompleted,
      'OwnerName': ownername,
      'GarageName': garageName,
      'Email': email,
      'MobileNo': mobileNo,
      'GeoLocation': geoLocation,
      'Pin': pin,
      'SID': SID,
      'LastSlotTime': LastSlotTime
    };
  }
}
