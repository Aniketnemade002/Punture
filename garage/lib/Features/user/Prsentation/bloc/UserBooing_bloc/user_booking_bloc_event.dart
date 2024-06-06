part of 'user_booking_bloc_bloc.dart';

sealed class UserBookingBlocEvent extends Equatable {
  const UserBookingBlocEvent();

  @override
  List<Object> get props => [];
}

class GetUserBookingList extends UserBookingBlocEvent {}
