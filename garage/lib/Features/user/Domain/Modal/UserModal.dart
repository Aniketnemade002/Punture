import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String fcm;
  final bool isProfileCompleted;
  final String name;
  final String email;
  final int mobileNo;
  final String village;
  final GeoPoint geoLocation;
  final int wallet;

  UserModel({
    required this.uid,
    required this.fcm,
    required this.isProfileCompleted,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.village,
    required this.geoLocation,
    required this.wallet,
  });

  @override
  List<Object?> get props => [
        uid,
        fcm,
        isProfileCompleted,
        name,
        email,
        mobileNo,
        village,
        geoLocation,
        wallet,
      ];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fcm': fcm,
      'isProfileCompleted': isProfileCompleted,
      'name': name,
      'email': email,
      'mobileNo': mobileNo,
      'village': village,
      'geoLocation': geoLocation,
      'wallet': wallet,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      fcm: json['fcm'],
      isProfileCompleted: json['isProfileCompleted'],
      name: json['name'],
      email: json['email'],
      mobileNo: json['mobileNo'],
      village: json['village'],
      geoLocation: json['geoLocation'],
      wallet: json['wallet'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? fcm,
    bool? isProfileCompleted,
    String? name,
    String? email,
    int? mobileNo,
    String? village,
    GeoPoint? geoLocation,
    int? wallet,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fcm: fcm ?? this.fcm,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      name: name ?? this.name,
      email: email ?? this.email,
      mobileNo: mobileNo ?? this.mobileNo,
      village: village ?? this.village,
      geoLocation: geoLocation ?? this.geoLocation,
      wallet: wallet ?? this.wallet,
    );
  }
}
