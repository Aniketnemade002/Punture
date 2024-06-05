import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';

import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class mainUserDataSource {
  Future<MainUserModal?> GetUser();
}

class mainUserDataSourceImpl implements mainUserDataSource {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  final String Who = isuser == true ? 'USER' : 'OWNER';

  @override
  Future<MainUserModal?> GetUser() async {
    try {
      final _Uid = await _fdb.currentUser!.uid;
      print('Getting User $_Uid');

      final _result = await _db.collection('USER').doc(_Uid).get();
      if (_result.exists) {
        final data = _result.data();
        if (data == null) {
          return null;
        }
        print("Data is${data.toString()} ");

        return MainUserModal.fromJson(data);
      }
    } catch (e) {
      print("peint ${e.toString()}");
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

