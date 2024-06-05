part of 'o_dash_bord_bloc.dart';

class ODashBordEvent extends Equatable {
  const ODashBordEvent();

  @override
  List<Object> get props => [];
}

class GetOwner extends ODashBordEvent {}

class GetOwnerBookingList extends ODashBordEvent {}

class GetOwnerHistoryList extends ODashBordEvent {}

class GetDelete_service extends ODashBordEvent {
  final String BookingId;
  final String owneruid;
  final String garageName;
  final String ownername;
  final int OwnerMobileNo;
  final int serviceCost;
  final GeoPoint GarageLocation;
  final String Address;
  final Timestamp SlotTime;
  final String SlotID;
  final String username;
  final String useruid;
  final String Discription;
  final String Vehical_No;
  final int userMobileNo;
  final GeoPoint CurrentLocation;

  GetDelete_service(
      {required this.BookingId,
      required this.owneruid,
      required this.garageName,
      required this.ownername,
      required this.OwnerMobileNo,
      required this.serviceCost,
      required this.GarageLocation,
      required this.Address,
      required this.SlotTime,
      required this.SlotID,
      required this.username,
      required this.useruid,
      required this.Discription,
      required this.Vehical_No,
      required this.userMobileNo,
      required this.CurrentLocation});

  @override
  List<Object> get props => [
        BookingId,
        owneruid,
        garageName,
        ownername,
        OwnerMobileNo,
        serviceCost,
        GarageLocation,
        Address,
        SlotTime,
        SlotID,
        username,
        useruid,
        Discription,
        Vehical_No,
        userMobileNo,
        CurrentLocation
      ];
}
