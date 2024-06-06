part of 'user_booking_bloc_bloc.dart';

sealed class UserBookingBlocState extends Equatable {
  const UserBookingBlocState();

  @override
  List<Object> get props => [];
}

final class UserBookingBlocInitial extends UserBookingBlocState {}

class GotBookingList extends UserBookingBlocState {
  final List<UserBookingDataModal> BookingList;

  GotBookingList({required this.BookingList});

  @override
  List<Object> get props => [BookingList];
}

class User_Loading_BookingList extends UserBookingBlocState {}

class User_Faild_BookingList extends UserBookingBlocState {}

class User_NoData_BookingList extends UserBookingBlocState {}
