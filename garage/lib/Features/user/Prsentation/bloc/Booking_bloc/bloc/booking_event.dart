part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class AddBooking extends BookingEvent {
  final String owneruid;
  final String garageName;
  final String ownername;
  final int OwnerMobileNo;
  final int serviceCost;
  final GeoPoint GarageLocation;
  final String address;

  final String SlotID;
  final dynamic SlotTime;

  final GeoPoint CurrentLocation;

  AddBooking(
      {required this.owneruid,
      required this.garageName,
      required this.ownername,
      required this.OwnerMobileNo,
      required this.serviceCost,
      required this.GarageLocation,
      required this.address,
      required this.SlotID,
      required this.SlotTime,
      required this.CurrentLocation});

  @override
  List<Object> get props => [
        owneruid,
        garageName,
        ownername,
        OwnerMobileNo,
        serviceCost,
        GarageLocation,
        address,
        SlotTime,
        SlotID,
        CurrentLocation,
      ];
}

class GetSlot extends BookingEvent {
  final String OwnerId;

  GetSlot({required this.OwnerId});
  @override
  List<Object> get props => [OwnerId];
}

class SelectSlot extends BookingEvent {
  final String SlotID;
  final Timestamp SlotTime;

  SelectSlot({required this.SlotID, required this.SlotTime});
  @override
  List<Object> get props => [SlotID, SlotTime];
}

class GetGarages extends BookingEvent {
  final String VillageName;

  GetGarages({required this.VillageName});
  @override
  List<Object> get props => [VillageName];
}

class vehical_No_Change extends BookingEvent {
  final String Vehical_No;
  const vehical_No_Change(this.Vehical_No);

  @override
  List<Object> get props => [Vehical_No];
}

class DiscriptionChange extends BookingEvent {
  final String Discription;
  const DiscriptionChange(this.Discription);

  @override
  List<Object> get props => [Discription];
}

class initial extends BookingEvent {}
