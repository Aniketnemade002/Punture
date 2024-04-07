import 'package:garage/auth/Domain/Eintity/LoginResponse.dart';

class UserResponseModal extends LoginResponse {
  UserResponseModal({
    required super.Uid,
    required super.isProfileCompleted,
    required super.isverified,
  });

  factory UserResponseModal.fromJson(Map<String, dynamic> json) {
    return UserResponseModal(
      isProfileCompleted: json['isprofileCompleted'],
      Uid: json['uid'] ?? '',
      isverified: json['isverified'] ?? '',
    );
  }
  UserResponseModal copyWith({
    String? Uid,
    bool? isprofileCompleted,
  }) =>
      UserResponseModal(
        Uid: Uid ?? this.Uid,
        isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
        isverified: isverified ?? this.isverified,
      );
}
