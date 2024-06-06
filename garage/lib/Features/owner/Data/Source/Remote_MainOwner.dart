import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class mainOwnerDataSource {
  Future<MainOwnerModal?> GetOwner();
}

class mainOwnerDataSourceImpl implements mainOwnerDataSource {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final String Who = isuser == true ? 'USER' : 'OWNER';

  @override
  Future<MainOwnerModal?> GetOwner() async {
    try {
      final _Uid = await _fdb.currentUser!.uid;
      print('Getting User $_Uid');

      final _result = await _db.collection('OWNER').doc(_Uid).get();
      if (_result.exists) {
        final data = _result.data();
        if (data == null) {
          return null;
        }
        print("Data is${data.toString()} ");

        return MainOwnerModal.fromJson(data);
      }
    } catch (e) {
      throw Exp(e);
    }
  }
}

class SlotDataSource {
  final _fdb = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final String _Who = 'OWNER';

  @override
  Future<void> AddSlot(Timestamp LastSlotTime) async {
    try {
      final _Uid = await _fdb.currentUser!.uid;
      print('Getting User $_Uid');
      //
      //
      //
      final CollectionReference SlotRef =
          _db.collection('OWNER').doc(_Uid).collection('SLOTS');

      final DocumentReference newSlotRef = SlotRef.doc();

      final SlotID = newSlotRef.id;
      print("Slot ID++++++++++++++++++++++++ (${SlotRef})");
      // FieldValue.increment(-1)
      //
      //

      await _db.collection('OWNER').doc(_Uid).set({
        'NoOfSlots': FieldValue.increment(1),
      }, SetOptions(merge: true));

      await _db.collection('OWNER').doc(_Uid).set({
        'LastSlotTime': LastSlotTime,
      }, SetOptions(merge: true));
      //
      //

      await newSlotRef.set({
        'SlotTime': LastSlotTime,
        'SlotID': SlotID,
      }, SetOptions(merge: true));
      //
      //
    } catch (e) {
      throw Exp(e);
    }
  }

  Future<Timestamp> GetLastSlot() async {
    try {
      final _UID = await _fdb.currentUser!.uid;

      final Result = await _db.collection('OWNER').doc(_UID).get();

      if (Result.exists) {
        final data = Result['LastSlotTime'];

        return data;
      } else {
        return Timestamp.now();
      }
    } catch (e) {
      print(e);
      throw Exp(e);
    }
  }
}

// if (_result.exists) {
//   final data = _result.data();
//   if (data == null) {
//     return null;
//   }
//   print("Data is${data.toString()} ");

//  final CollectionReference BookingRef =
//           _db.collection('OWNER').doc(_Uid).collection('BOOKINGS');
//       final DocumentReference newBookingRef = BookingRef.doc();

//       final CollectionReference HistoryRef =
//           _db.collection('OWNER').doc(_Uid).collection('HISTORY');
//       final DocumentReference newHistoryRef = HistoryRef.doc();
