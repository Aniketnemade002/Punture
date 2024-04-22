part of 'user_register_bloc.dart';

class UserRegisterState extends Equatable {
  final FormzSubmissionStatus status;

  final String fcm;
  final Address village;
  final int wallet;
  final bool isProfileCompleted;
  final Name name;
  final Email email;
  final MobileNumber mobileNo;
  final bool isvalid;
  final l.GeoPointInput geoLocation;
  final PIN pin;
  final ConfirmPIN confirmpin;

  const UserRegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.isvalid = false,
    this.fcm = '',
    this.isProfileCompleted = false,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.mobileNo = const MobileNumber.pure(),
    this.village = const Address.pure(),
    this.geoLocation = const l.GeoPointInput.pure(),
    this.wallet = 0,
    this.pin = const PIN.pure(),
    this.confirmpin = const ConfirmPIN.pure(),
  });

  UserRegisterState copyWith({
    String? fcm,
    bool? isProfileCompleted,
    Name? name,
    bool? isvalid,
    Email? email,
    MobileNumber? mobileNo,
    Address? village,
    l.GeoPointInput? geoLocation,
    int? wallet,
    PIN? pin,
    ConfirmPIN? confirmpin,
    FormzSubmissionStatus? status,
  }) {
    return UserRegisterState(
      fcm: fcm ?? this.fcm,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      name: name ?? this.name,
      isvalid: isvalid ?? this.isvalid,
      email: email ?? this.email,
      mobileNo: mobileNo ?? this.mobileNo,
      village: village ?? this.village,
      geoLocation: geoLocation ?? this.geoLocation,
      wallet: wallet ?? this.wallet,
      pin: pin ?? this.pin,
      confirmpin: confirmpin ?? this.confirmpin,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        isvalid,
        fcm,
        isProfileCompleted,
        name,
        email,
        mobileNo,
        village,
        geoLocation,
        wallet,
        pin,
        confirmpin,
        status
      ];
}

// final class UserRegisterInitial extends UserRegisterState {
//   UserRegisterInitial({required super.fcm, required super.isProfileCompleted});
// }

// final class UserRegisterLoading extends UserRegisterState {
//   UserRegisterLoading({required super.fcm, required super.isProfileCompleted});
// }
