part of 'slot_bloc.dart';

sealed class SlotState extends Equatable {
  const SlotState();

  @override
  List<Object> get props => [];
}

final class SlotInitial extends SlotState {}

class SlotLoading extends SlotState {}

class SlotGetFailure extends SlotState {}

class SlotAddFailure extends SlotState {}

class SlotAddSucsess extends SlotState {}

class GetLastSlot extends SlotState {
  final DateTime LastTimeDate;

  const GetLastSlot(this.LastTimeDate);

  @override
  List<Object> get props => [LastTimeDate];
}
