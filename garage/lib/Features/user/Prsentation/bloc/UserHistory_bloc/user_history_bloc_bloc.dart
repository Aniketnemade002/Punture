import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
import 'package:garage/Features/user/Data/RepoImp/MainUserImpl.dart';
import 'package:garage/core/Error/Error.dart';

part 'user_history_bloc_event.dart';
part 'user_history_bloc_state.dart';

class UserHistoryBlocBloc
    extends Bloc<UserHistoryBlocEvent, UserHistoryBlocState> {
  UserBookingHistoryRepoImpl _userBookingHistoryRepoImpl =
      UserBookingHistoryRepoImpl();
  UserHistoryBlocBloc() : super(UserHistoryBlocInitial()) {
    on<GetUserHistoryList>(_GetUserHistoryList);
  }

  void _GetUserHistoryList(
    GetUserHistoryList event,
    Emitter<UserHistoryBlocState> emit,
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
