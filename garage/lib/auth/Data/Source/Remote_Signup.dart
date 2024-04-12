import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class SignUpDataSource {
  Future<bool> SignUp({required String email, required String password});
  Future<bool> SendVerificationEmail();
  Future<bool> ReSendVerificationEmail();
}

class SignUpDataSourceImpl implements SignUpDataSource {
  final fdb = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final String Who = isuser == true ? 'USER' : 'OWNER';

  @override
  Future<bool> ReSendVerificationEmail() async {
    try {
      final user = fdb.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exp(e);
    }
  }

  @override
  Future<bool> SendVerificationEmail() async {
    try {
      final user = fdb.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exp(e);
    }
  }

  @override
  Future<bool> SignUp({required String email, required String password}) async {
    try {
      final users = await fdb.createUserWithEmailAndPassword(
          email: email, password: password);

      final Uid = users.user!.uid;

      try {
        await db.collection(Who).doc(Uid).set({
          'UID': Uid,
          'isProfileCompleted': false,
        });
        return true;
      } catch (e) {
        throw Exp(e);
      }
    } catch (e) {
      throw Exp(e);
    }
  }
}
