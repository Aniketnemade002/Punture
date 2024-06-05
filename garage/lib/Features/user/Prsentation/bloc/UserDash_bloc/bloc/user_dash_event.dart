part of 'user_dash_bloc.dart';

sealed class UserDashEvent extends Equatable {
  const UserDashEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends UserDashEvent {}

class GetUserBookingList extends UserDashEvent {}

class GetUserHistoryList extends UserDashEvent {}
