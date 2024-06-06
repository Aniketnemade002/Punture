part of 'owner_history_bloc_bloc.dart';

sealed class OwnerHistoryBlocState extends Equatable {
  const OwnerHistoryBlocState();

  @override
  List<Object> get props => [];
}

final class OwnerHistoryBlocInitial extends OwnerHistoryBlocState {}

class GotHistorygList extends OwnerHistoryBlocState {
  final List<OwnerHistoryModal> HistoryBookingList;

  GotHistorygList({required this.HistoryBookingList});

  @override
  List<Object> get props => [HistoryBookingList];
}

class Owner_LoadingHistorygList extends OwnerHistoryBlocState {}

class Owner_Faild_LoadingHistorygList extends OwnerHistoryBlocState {}

class Owner_No_Data_HistorygList extends OwnerHistoryBlocState {}
