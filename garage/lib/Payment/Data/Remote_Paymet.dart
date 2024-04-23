import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';

class OwnerPaymentDataSource {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<bool> WithadreawPay(int Ammount) async {
    try {
      final _UID = await _fdb.currentUser!.uid;

      final Result =
          await _db.collection('USER').doc(_UID).set({'Wallet': Ammount});
      return true;
    } catch (e) {
      throw Exp(e);
    }
  }

  Future<int> Get() async {
    try {
      final _UID = await _fdb.currentUser!.uid;

      final Result = await _db.collection('USER').doc(_UID).get();

      if (Result.exists) {
        final data = Result.data()?['Wallet'];
        return data;
      } else {
        return 0;
      }
    } catch (e) {
      throw Exp(e);
    }
  }
}

class UserPaymentDataSource {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  Future<bool> Pay(int Ammount) async {
    try {
      final _UID = await _fdb.currentUser!.uid;
      await _db.collection('OWNER').doc(_UID).set({'Wallet': Ammount});
      return true;
    } catch (e) {
      throw Exp(e);
    }
  }

  Future<int> Get() async {
    try {
      final _UID = await _fdb.currentUser!.uid;

      final Result = await _db.collection('OWNER').doc(_UID).get();

      if (Result.exists) {
        final data = Result.data()?['Wallet'];
        return data;
      } else {
        return 0;
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
