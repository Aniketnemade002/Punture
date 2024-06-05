import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/Features/owner/Data/RepoImp/SlotRepo.dart';
import 'package:garage/core/Error/Error.dart';

part 'slot_event.dart';
part 'slot_state.dart';

class SlotBloc extends Bloc<SlotEvent, SlotState> {
  SlotRepoImpl _slotRepoImpl = SlotRepoImpl();
  SlotBloc() : super(SlotInitial()) {
    on<LastSlotRequested>(_LastSlotRequested);
    on<AddSlotRequested>(_AddSlotRequested);
  }

  void _LastSlotRequested(
    LastSlotRequested event,
    Emitter<SlotState> emit,
  ) async {
    try {
      emit(SlotLoading());
      print('Clicked 1');
      final result = await _slotRepoImpl.GetLastSlot();
      print('Clicked 2');

      result.fold((l) {
        Failure.handle(l.exp);

        emit(SlotGetFailure());
      }, (r) {
        final _result = r.toDate();
        emit(GetLastSlot(_result));
      });
    } catch (e) {
      emit(SlotGetFailure());
    }
  }

  void _AddSlotRequested(
    AddSlotRequested event,
    Emitter<SlotState> emit,
  ) async {
    try {
      emit(SlotLoading());
      final result =
          await _slotRepoImpl.AddSlot(Timestamp.fromDate(event.slotTime));

      result.fold((l) {
        Failure.handle(l.exp);
        emit(SlotAddFailure());
      }, (r) {
        if (r) {
          emit(SlotAddSucsess());
        } else {
          emit(SlotAddFailure());
        }
      });
    } catch (e) {
      emit(SlotAddFailure());
    }
  }
}
