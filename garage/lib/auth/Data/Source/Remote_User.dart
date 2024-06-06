import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';

import '../ModalImpl/UserResponseImpl.dart';

abstract interface class UserDataSource {
  Future<bool> SendVerificationEmail();
  Future<bool> ReSendVerificationEmail();
  Future<bool> islogedIn();
  Future<bool> isverified();
  Future<bool> PasswordReset({required String email});
  Future<void> Logout();
  Future<void> OwnerSaveFcmTocken({required String token});

  Future<LoginResponseModal?> LogIn({
    required String email,
    required String password,
  });
}

class UserDataSourceImpl implements UserDataSource {
  final fdb = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Future<LoginResponseModal?> LogIn(
      {required String email, required String password}) async {
    String Who = isuser ? 'USER' : 'OWNER';
    print("got.++++++++++++${isuser}");
    try {
      final userCredential = await fdb.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final Uid = userCredential.user!.uid;
      final isVerified = userCredential.user!.emailVerified;
      print("Values got +++");
      print("Values got +++ who is 8888888888888  $Who");

      await pref.setString('S_UserEntity', Who);
      print("Values got ++++++++");
      final DocumentSnapshot<Map<String, dynamic>> snap =
          await db.collection(Who).doc(Uid).get();
      print("Values  Fuck ++++++++");
      if (snap.exists) {
        print("${snap.data()}");
        print(snap.data().toString());
        final isProfileCompleted = snap.data()!['isProfileCompleted'];

        final result = LoginResponseModal(
          Uid: Uid,
          isProfileCompleted: isProfileCompleted,
          isverified: isVerified,
        );
        print("Values got +++++++++++++++");
        return result;
      } else {
        // User does not exist
        return null;
      }
    } catch (e) {
      throw Exp(e);
    }
  }

  @override
  Future<void> Logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Failure.handle(e);
    }
  }

  @override
  Future<bool> PasswordReset({required String email}) async {
    try {
      await fdb.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      throw Exp(e);
    }
  }

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
  Future<void> OwnerSaveFcmTocken({required String token}) async {
    try {
      final Uid = await fdb.currentUser!.uid;
      print("Previous Uid $UserUid ");
      print("Previous Uid $Uid ");
      print("FCM Token $token ");

      await db
          .collection('OWNER')
          .doc(Uid)
          .set({'FCM': token}, SetOptions(merge: true));
    } catch (e) {
      throw Exp(e);
    }
  }

  Future<void> UserSaveFcmTocken({required String token}) async {
    try {
      final Uid = await fdb.currentUser!.uid;
      print("Previous Uid $UserUid ");
      print("Previous Uid $Uid ");
      print("FCM Token $token ");

      await db
          .collection('USER')
          .doc(Uid)
          .set({'FCM': token}, SetOptions(merge: true));
    } catch (e) {
      throw Exp(e);
    }
  }

  @override
  Future<bool> SendVerificationEmail() async {
    try {
      final user = await fdb.currentUser;
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
  Future<bool> isverified() async {
    try {
      final user = fdb.currentUser;
      if (user != null) {
        final result = await user.emailVerified;
        return result;
      } else {
        return false;
      }
    } catch (e) {
      throw Exp(e);
    }
  }

  @override
  Future<bool> islogedIn() async {
    try {
      final user = await fdb.currentUser;
      if (user != null) {
        return true;
      } else {
        return false;
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









//  if (userCredential.user!.emailVerified) {
//           return UserResponseModal.fromJson({
//             'uid': uid,
//             'isProfileCompleted': snap['isProfileCompleted'],
//           });
//         } else {
//           // If email is not verified, sign out and redirect to login screen
//           await _firebaseAuth.signOut();
//           return null; // You might want to handle this differently in your app
//         }