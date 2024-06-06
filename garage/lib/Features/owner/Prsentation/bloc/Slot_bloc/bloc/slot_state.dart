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

class GotLastSlot extends SlotState {
  final DateTime SlotTimeDate;

  const GotLastSlot(this.SlotTimeDate);

  @override
  List<Object> get props => [SlotTimeDate];
}
