import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
import 'package:garage/Features/user/Data/RepoImp/MainUserImpl.dart';
import 'package:garage/core/Error/Error.dart';

part 'user_booking_bloc_event.dart';
part 'user_booking_bloc_state.dart';

class UserBookingBlocBloc
    extends Bloc<UserBookingBlocEvent, UserBookingBlocState> {
  UserBookingDataRepoImpl _userBookingDataRepoImpl = UserBookingDataRepoImpl();
  UserBookingBlocBloc() : super(UserBookingBlocInitial()) {
    on<GetUserBookingList>(_GetUserBookingList);
  }

  void _GetUserBookingList(
    GetUserBookingList event,
    Emitter<UserBookingBlocState> emit,
  ) async {
    emit(User_Loading_BookingList());
    try {
      print('+++++++++++++++++++ Booking Requested From User Bloc+++++++');
      final _Result = await _userBookingDataRepoImpl.GetBookings();

      _Result.fold((l) {
        emit(User_Faild_BookingList());
        Failure.handle(l.exp);
      }, (r) {
        if (r == null) {
          print(
              "++++++++++++++++++++++++++No Booking Found+++++++++++++++++++");
          emit(User_NoData_BookingList());
        } else {
          if (r == []) {
            print(
                "++++++++++++++++++++++++++No Booking Found+++++++++++++++++++");
            emit(User_NoData_BookingList());
          } else {
            emit(GotBookingList(BookingList: r));
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
