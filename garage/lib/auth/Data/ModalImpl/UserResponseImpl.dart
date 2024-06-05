import 'package:garage/auth/Domain/Eintity/LoginResponse.dart';

class LoginResponseModal extends LoginResponse {
  LoginResponseModal({
    required super.Uid,
    required super.isProfileCompleted,
    required super.isverified,
  });

  factory LoginResponseModal.fromJson(Map<String, dynamic> json) {
    return LoginResponseModal(
      isProfileCompleted: json['isprofileCompleted'],
      Uid: json['uid'] ?? '',
      isverified: json['isverified'] ?? '',
    );
  }
  LoginResponseModal copyWith({
    String? Uid,
    bool? isprofileCompleted,
  }) =>
      LoginResponseModal(
        Uid: Uid ?? this.Uid,
        isProfileCompleted: isProfileCompleted,
        isverified: isverified,
      );
}
