part of 'user_history_bloc_bloc.dart';

sealed class UserHistoryBlocEvent extends Equatable {
  const UserHistoryBlocEvent();

  @override
  List<Object> get props => [];
}

class GetUserHistoryList extends UserHistoryBlocEvent {}
