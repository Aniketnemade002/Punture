part of 'slot_bloc.dart';

sealed class SlotEvent extends Equatable {
  const SlotEvent();

  @override
  List<Object> get props => [];
}

class LastSlotRequested extends SlotEvent {}

class AddSlotRequested extends SlotEvent {
  final DateTime slotTime;

  const AddSlotRequested(this.slotTime);

  @override
  List<Object> get props => [slotTime];
}
