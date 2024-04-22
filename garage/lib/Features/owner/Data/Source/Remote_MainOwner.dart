import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class mainOwnerDataSource {
  Future<MainOwnerModal?> GetOwner();
}

class mainOwnerDataSourceImpl implements mainOwnerDataSource {
  final fdb = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final String Who = isuser == true ? 'USER' : 'OWNER';
  @override
  Future<MainOwnerModal?> GetOwner() async {
    try {
      final _result = await db.collection(Who).doc(UserUid).get();

      if (_result.exists) {
        return MainOwnerModal.fromJson(_result.data()!);
      } else {
        return null;
      }
    } catch (e) {
      throw Exp(e);
    }
  }
}
