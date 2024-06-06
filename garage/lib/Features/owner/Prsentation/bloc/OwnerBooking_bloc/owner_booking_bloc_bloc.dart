import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
import 'package:garage/Features/owner/Data/RepoImp/MainOwnerRepoImpl.dart';
import 'package:garage/core/Error/Error.dart';

part 'owner_booking_bloc_event.dart';
part 'owner_booking_bloc_state.dart';

class OwnerBookingBlocBloc
    extends Bloc<OwnerBookingBlocEvent, OwnerBookingBlocState> {
  BookingRepoImpl _bookingRepoImpl = BookingRepoImpl();
  OwnerBookingBlocBloc() : super(OwnerBookingBlocInitial()) {
    on<GetOwnerBookingList>(_GetOwnerBookingList);
  }

  void _GetOwnerBookingList(
    GetOwnerBookingList event,
    Emitter<OwnerBookingBlocState> emit,
  ) async {
    emit(Owner_Loading_BookingList());
    try {
      final _Result = await _bookingRepoImpl.GetBookings();

      _Result.fold((l) {
        emit(Owner_Faild_BookingList());
        Failure.handle(l.exp);
      }, (r) {
        if (r == null) {
          emit(Owner_NoData_BookingList());
        } else {
          emit(GotBookingList(BookingList: r));
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
