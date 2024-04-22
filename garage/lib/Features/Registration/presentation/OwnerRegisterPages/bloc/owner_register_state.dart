part of 'owner_register_bloc.dart';

class OwnerRegisterState extends Equatable {
  final FormzSubmissionStatus? status;

  final String fcm;
  final Address village;
  final int wallet;
  final bool isProfileCompleted;
  final GarageName garageName;
  final ServiceCost serviceCost;
  final Name ownername;
  final Email email;
  final MobileNumber mobileNo;
  final bool isvalid;
  final l.GeoPointInput geoLocation;
  final PIN pin;
  final FullAddress fullAddress;
  final ConfirmPIN confirmpin;
  final int SID;

  const OwnerRegisterState({
    this.fullAddress = const FullAddress.pure(),
    this.garageName = const GarageName.pure(),
    this.serviceCost = const ServiceCost.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isvalid = false,
    this.fcm = '',
    this.isProfileCompleted = false,
    this.ownername = const Name.pure(),
    this.email = const Email.pure(),
    this.mobileNo = const MobileNumber.pure(),
    this.village = const Address.pure(),
    this.geoLocation = const l.GeoPointInput.pure(),
    this.wallet = 0,
    this.SID = 0,
    this.pin = const PIN.pure(),
    this.confirmpin = const ConfirmPIN.pure(),
  });

  OwnerRegisterState copyWith({
    FullAddress? fullAddress,
    GarageName? garageName,
    ServiceCost? serviceCost,
    String? fcm,
    bool? isProfileCompleted,
    Name? ownername,
    bool? isvalid,
    Email? email,
    MobileNumber? mobileNo,
    Address? village,
    l.GeoPointInput? geoLocation,
    int? wallet,
    PIN? pin,
    int? SID,
    ConfirmPIN? confirmpin,
    FormzSubmissionStatus? status,
  }) {
    return OwnerRegisterState(
      fullAddress: fullAddress ?? this.fullAddress,
      garageName: garageName ?? this.garageName,
      serviceCost: serviceCost ?? this.serviceCost,
      fcm: fcm ?? this.fcm,
      SID: SID ?? this.SID,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      ownername: ownername ?? this.ownername,
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
        fullAddress,
        serviceCost,
        garageName,
        isvalid,
        fcm,
        isProfileCompleted,
        ownername,
        email,
        mobileNo,
        village,
        geoLocation,
        wallet,
        pin,
        confirmpin,
        status,
        SID
      ];
}
