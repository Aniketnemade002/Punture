part of 'user_history_bloc_bloc.dart';

sealed class UserHistoryBlocState extends Equatable {
  const UserHistoryBlocState();

  @override
  List<Object> get props => [];
}

final class UserHistoryBlocInitial extends UserHistoryBlocState {}

class GotHistorygList extends UserHistoryBlocState {
  final List<UserHistoryModal> HistoryBookingList;

  GotHistorygList({required this.HistoryBookingList});

  @override
  List<Object> get props => [HistoryBookingList];
}

class User_LoadingHistorygList extends UserHistoryBlocState {}

class User_Faild_LoadingHistorygList extends UserHistoryBlocState {}

class User_No_Data_HistorygList extends UserHistoryBlocState {}
