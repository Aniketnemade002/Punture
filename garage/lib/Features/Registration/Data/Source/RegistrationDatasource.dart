import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/constant/constant.dart';

import 'package:garage/core/Error/Error.dart';

abstract interface class UserRegisterDataSource {
  Future<bool> UserRegister({
    required String fcm,
    required String village,
    required int wallet,
    required bool isProfileCompleted,
    required String name,
    required String email,
    required int mobileNo,
    required GeoPoint geoLocation,
    required int pin,
  });
}

abstract interface class OwnerRegisterRepoDataSource {
  Future<bool> OwnerRegister({
    required String fcm,
    required String village,
    required String Address,
    required int ServiceCost,
    required int wallet,
    required bool isProfileCompleted,
    required String OwnerName,
    required String GarageName,
    required String email,
    required int mobileNo,
    required GeoPoint geoLocation,
    required int pin,
    required int SID,
  });
}

class UserRegisterDataSourceImpl implements UserRegisterDataSource {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  @override
  Future<bool> UserRegister(
      {required String fcm,
      required String village,
      required int wallet,
      required bool isProfileCompleted,
      required String name,
      required String email,
      required int mobileNo,
      required GeoPoint geoLocation,
      required int pin}) async {
    try {
      final _Uid = await _fdb.currentUser!.uid;
      final userData = {
        'FCM': fcm,
        'Village': village,
        'Wallet': wallet,
        'isProfileCompleted': isProfileCompleted,
        'name': name,
        'Email': email,
        'MobileNo': mobileNo,
        'GeoLocation': geoLocation,
        'Pin': pin,
      };

      final result = await _db.collection('USER').doc(_Uid).set(userData);

      return true;
    } catch (e) {
      throw Exp(e);
    }
  }
}

class OwnerRegisterDataSourceImpl implements OwnerRegisterRepoDataSource {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  @override
  Future<bool> OwnerRegister(
      {required String fcm,
      required String village,
      required String Address,
      required int ServiceCost,
      required int wallet,
      required bool isProfileCompleted,
      required String OwnerName,
      required String GarageName,
      required String email,
      required int mobileNo,
      required GeoPoint geoLocation,
      required int pin,
      required int SID}) async {
    try {
      final String _Uid = _fdb.currentUser!.uid;

      final Map<String, dynamic> ownerData = {
        'FCM': fcm,
        'Village': village,
        'Address': Address,
        'ServiceCost': ServiceCost,
        'Wallet': wallet,
        'isProfileCompleted': isProfileCompleted,
        'OwnerName': OwnerName,
        'GarageName': GarageName,
        'Email': email,
        'MobileNo': mobileNo,
        'GeoLocation': geoLocation,
        'Pin': pin,
        'SID': SID,
      };

      await _db.collection('OWNER').doc(_Uid).set(ownerData);

      return true;
    } catch (e) {
      throw Exp(e);
    }
  }
}








//  async {
//     try {
  
//       try {
      
//       } catch (e) {
//         throw Exp(e);
//       }
//     } catch (e) {
//       throw Exp(e);
//     }
//   }