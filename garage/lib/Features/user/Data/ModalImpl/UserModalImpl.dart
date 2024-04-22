import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage/Features/user/Domain/Entity/UserModal.dart';

class MainUserModal extends MainUser {
  MainUserModal(
      {required super.fcm,
      required super.village,
      required super.wallet,
      required super.isProfileCompleted,
      required super.name,
      required super.email,
      required super.mobileNo,
      required super.geoLocation,
      required super.pin});

//  'FCM': fcm,
//         'Village': village,
//         'Wallet': wallet,
//         'isProfileCompleted': isProfileCompleted,
//         'name': name,
//         'Email': email,
//         'MobileNo': mobileNo,
//         'GeoLocation': geoLocation,
//         'Pin': pin,
  factory MainUserModal.fromJson(Map<String, dynamic> json) {
    return MainUserModal(
      fcm: json['FCM'] as String,
      village: json['Village'] as String,
      wallet: json['Wallet'] as int,
      isProfileCompleted: json['isProfileCompleted'] as bool,
      name: json['name'] as String,
      email: json['Email'] as String,
      mobileNo: json['MobileNo'] as int,
      geoLocation: json['GeoLocation'] as GeoPoint,
      pin: json['Pin'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FCM': fcm,
      'Village': village,
      'Wallet': wallet,
      'isProfileCompleted': isProfileCompleted,
      'name': name,
      'Email': email,
      'mobileNo': mobileNo,
      'GeoLocation': geoLocation,
      'Pin': pin,
    };
  }
}
