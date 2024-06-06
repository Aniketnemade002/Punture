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

class OwnerLoading extends ODashBordState {}

class OwnerLoadFaild extends ODashBordState {}

///
///
///
///
///
///

///
///
///
///
///
///
///
///
///

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
