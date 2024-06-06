part of 'owner_history_bloc_bloc.dart';

sealed class OwnerHistoryBlocEvent extends Equatable {
  const OwnerHistoryBlocEvent();

  @override
  List<Object> get props => [];
}

class GetOwnerHistoryList extends OwnerHistoryBlocEvent {}
