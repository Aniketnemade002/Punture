part of 'owner_booking_bloc_bloc.dart';

sealed class OwnerBookingBlocState extends Equatable {
  const OwnerBookingBlocState();

  @override
  List<Object> get props => [];
}

final class OwnerBookingBlocInitial extends OwnerBookingBlocState {}

class GotBookingList extends OwnerBookingBlocState {
  final List<OwnerBookingModal> BookingList;

  GotBookingList({required this.BookingList});

  @override
  List<Object> get props => [BookingList];
}

class Owner_Loading_BookingList extends OwnerBookingBlocState {}

class Owner_Faild_BookingList extends OwnerBookingBlocState {}

class Owner_NoData_BookingList extends OwnerBookingBlocState {}
