import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';
import 'package:garage/Features/user/Data/RepoImp/MainUserImpl.dart';
import 'package:garage/Features/user/Data/Source/Remote_MainUser.dart';
import 'package:garage/core/Error/Error.dart';

part 'user_dash_event.dart';
part 'user_dash_state.dart';

class UserDashBloc extends Bloc<UserDashEvent, UserDashState> {
  MainUserRepoImpl _MainUserRepoImpl = MainUserRepoImpl();
  UserBookingDataRepoImpl _userBookingDataRepoImpl = UserBookingDataRepoImpl();
  UserBookingHistoryRepoImpl _userBookingHistoryRepoImpl =
      UserBookingHistoryRepoImpl();

  UserDashBloc() : super(UserDashInitial()) {
    on<GetUser>(_GetUser);
    on<GetUserBookingList>(_GetUserBookingList);
    on<GetUserHistoryList>(_GetUserHistoryList);
  }

  void _GetUser(
    GetUser event,
    Emitter<UserDashState> emit,
  ) async {
    emit(GotUserLoading());
    try {
      emit(UserLoadFaild());
      final _Result = await _MainUserRepoImpl.GetUser();

      _Result.fold((l) {
        emit(UserLoadFaild());
        Failure.handle(l.exp);
      }, (r) {
        if (r == null) {
          emit(UserLoadFaild());
        } else {
          emit(GotUser(user: r));
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _GetUserBookingList(
    GetUserBookingList event,
    Emitter<UserDashState> emit,
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

  void _GetUserHistoryList(
    GetUserHistoryList event,
    Emitter<UserDashState> emit,
  ) async {
    emit(User_LoadingHistorygList());
    try {
      final _Result = await _userBookingHistoryRepoImpl.GetHistory();

      _Result.fold((l) {
        emit(User_Faild_LoadingHistorygList());
        Failure.handle(l.exp);
      }, (r) {
        if (r == null) {
          emit(User_No_Data_HistorygList());
        } else {
          if (r == []) {
            emit(User_No_Data_HistorygList());
          } else {
            emit(GotHistorygList(HistoryBookingList: r));
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
