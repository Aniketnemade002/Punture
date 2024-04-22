import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';

import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class mainUserDataSource {
  Future<MainUserModal?> GetUser();
}

class mainUserDataSourceImpl implements mainUserDataSource {
  final fdb = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final _storage = storage;
  final String Who = isuser == true ? 'USER' : 'OWNER';

  @override
  Future<MainUserModal?> GetUser() async {
    try {
      final _result = await db.collection(Who).doc(UserUid).get();

      if (_result.exists) {
        return MainUserModal.fromJson(_result.data()!);
      } else {
        return null;
      }
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

