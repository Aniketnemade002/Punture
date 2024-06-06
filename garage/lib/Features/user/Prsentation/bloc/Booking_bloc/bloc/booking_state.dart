part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final FormzSubmissionStatus status;
  final String owneruid;
  final String garageName;
  final String ownername;
  final int OwnerMobileNo;
  final int serviceCost;
  final GeoPoint GarageLocation;
  final String address;
  final bool isValid;

  final String username;
  final String SlotID;
  final String useruid;
  final int userMobileNo;
  final GeoPoint CurrentLocation;

  final FullAddress Discription;
  final GarageName Vehical_No;

  DateTime constantDateTime = DateTime(2023, 6, 1, 12, 0);

  BookingState({
    this.status = FormzSubmissionStatus.initial,
    this.owneruid = '',
    this.isValid = false,
    this.garageName = '',
    this.ownername = '',
    this.OwnerMobileNo = 0,
    this.serviceCost = 0,
    this.GarageLocation = const GeoPoint(0, 0),
    this.address = '',
    this.username = '',
    this.SlotID = '',
    this.useruid = '',
    this.userMobileNo = 0,
    this.CurrentLocation = const GeoPoint(0, 0),
    this.Discription = const FullAddress.pure(),
    this.Vehical_No = const GarageName.dirty(),
  });

  BookingState copyWith({
    FormzSubmissionStatus? status,
    String? owneruid,
    String? garageName,
    String? ownername,
    int? OwnerMobileNo,
    int? serviceCost,
    GeoPoint? GarageLocation,
    String? address,
    String? username,
    bool? isValid,
    String? SlotID,
    String? useruid,
    int? userMobileNo,
    GeoPoint? CurrentLocation,
    FullAddress? discription,
    GarageName? vehicalNo,
  }) {
    return BookingState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      owneruid: owneruid ?? this.owneruid,
      garageName: garageName ?? this.garageName,
      ownername: ownername ?? this.ownername,
      OwnerMobileNo: OwnerMobileNo ?? this.OwnerMobileNo,
      serviceCost: serviceCost ?? this.serviceCost,
      GarageLocation: GarageLocation ?? this.GarageLocation,
      address: address ?? this.address,
      username: username ?? this.username,
      SlotID: SlotID ?? this.SlotID,
      useruid: useruid ?? this.useruid,
      userMobileNo: userMobileNo ?? this.userMobileNo,
      CurrentLocation: CurrentLocation ?? this.CurrentLocation,
      Discription: discription ?? this.Discription,
      Vehical_No: vehicalNo ?? this.Vehical_No,
    );
  }

  @override
  List<Object> get props => [
        status,
        isValid,
        owneruid,
        garageName,
        ownername,
        OwnerMobileNo,
        serviceCost,
        GarageLocation,
        address,
        username,
        SlotID,
        useruid,
        userMobileNo,
        CurrentLocation,
        Discription,
        Vehical_No,
      ];
}

class FeatchedSlotList extends BookingState {
  final List<FeatchSlotImpl> SlotList;

  FeatchedSlotList({required this.SlotList});
  @override
  List<Object> get props => [SlotList];
}

class FeatchedGarages extends BookingState {
  final List<FeatchGarageMoadlImpl> GarageList;

  FeatchedGarages({required this.GarageList});
  @override
  List<Object> get props => [GarageList];
}

class FeatchedSlotListFaild extends BookingState {}

class FeatchedGaragesFaild extends BookingState {}

class FeatchedGaragesLoading extends BookingState {}

class Loading extends BookingState {}

class FeatchedSlotListLoading extends BookingState {}

class NoDataGarage extends BookingState {}

class NoDataSlot extends BookingState {}

class Sucsess extends BookingState {}

class LowBalence extends BookingState {}

class initializ extends BookingState {}
