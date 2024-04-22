import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage/Features/owner/Domain/Entity/Owner.dart';
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
      required super.SID});

  factory MainOwnerModal.fromJson(Map<String, dynamic> json) {
    return MainOwnerModal(
      fcm: json['FCM'] ?? '',
      village: json['Village'] ?? '',
      Address: json['Address'] ?? '',
      serviceCost: json['ServiceCost'] ?? 0,
      wallet: json['Wallet'] as int,
      isProfileCompleted: json['isProfileCompleted'] as bool,
      ownername: json['OwnerName'] as String,
      garageName: json['GarageName'] as String,
      email: json['Email'] as String,
      mobileNo: json['MobileNo'] as int,
      geoLocation: json['GeoLocation'] as GeoPoint,
      pin: json['Pin'] as int,
      SID: json['SID'] as int,
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
    };
  }
}
