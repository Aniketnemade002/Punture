part of 'user_dash_bloc.dart';

sealed class UserDashState extends Equatable {
  const UserDashState();

  @override
  List<Object> get props => [];
}

class UserDashInitial extends UserDashState {}

class GotUserLoading extends UserDashState {}

class GotUser extends UserDashState {
  final MainUserModal user;

  GotUser({required this.user});
  @override
  List<Object> get props => [user];
}

class GotBookingList extends UserDashState {
  final List<UserBookingDataModal> BookingList;

  GotBookingList({required this.BookingList});

  @override
  List<Object> get props => [BookingList];
}

class GotHistorygList extends UserDashState {
  final List<UserHistoryModal> HistoryBookingList;

  GotHistorygList({required this.HistoryBookingList});

  @override
  List<Object> get props => [HistoryBookingList];
}
// List<UserHistoryModal>

class UserLoading extends UserDashState {}

class UserLoadFaild extends UserDashState {}

///
///
///User
///
///
///

class User_LoadingHistorygList extends UserDashState {}

class User_Faild_LoadingHistorygList extends UserDashState {}

class User_No_Data_HistorygList extends UserDashState {}

///
///
///
///
///
///

class User_Loading_BookingList extends UserDashState {}

class User_Faild_BookingList extends UserDashState {}

class User_NoData_BookingList extends UserDashState {}
