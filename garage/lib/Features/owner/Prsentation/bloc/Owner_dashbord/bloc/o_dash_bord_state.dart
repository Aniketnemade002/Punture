part of 'o_dash_bord_bloc.dart';

sealed class ODashBordState extends Equatable {
  const ODashBordState();

  @override
  List<Object> get props => [];
}

class ODashBordInitial extends ODashBordState {}

class GotOwner extends ODashBordState {
  final MainOwnerModal owner;

  GotOwner({required this.owner});
  @override
  List<Object> get props => [owner];
}

class GotBookingList extends ODashBordState {
  final List<OwnerBookingModal> BookingList;

  GotBookingList({required this.BookingList});

  @override
  List<Object> get props => [BookingList];
}

class GotHistorygList extends ODashBordState {
  final List<OwnerHistoryModal> HistoryBookingList;

  GotHistorygList({required this.HistoryBookingList});

  @override
  List<Object> get props => [HistoryBookingList];
}

class OwnerLoading extends ODashBordState {}

class OwnerLoadFaild extends ODashBordState {}

///
///
///
///
///
///

class Owner_LoadingHistorygList extends ODashBordState {}

class Owner_LoadingFaild_LoadingHistorygList extends ODashBordState {}

class Owner_No_Data_HistorygList extends ODashBordState {}

///
///
///
///
///
///

class Owner_Loading_BookingList extends ODashBordState {}

class Owner_Faild_BookingList extends ODashBordState {}

class Owner_NoData_BookingList extends ODashBordState {}

///
///
///
///
///
///
///
///
///
class Delete_service_Loading extends ODashBordState {}

class Delete_service_Faild extends ODashBordState {}

class Delete_service_sucsess extends ODashBordState {}

class Initial extends ODashBordState {}
