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

// List<UserHistoryModal>

class UserLoading extends UserDashState {}

class UserLoadFaild extends UserDashState {}

///
///
///User
///
///
///
///
///
///
///
///
///
