import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
import 'package:garage/Features/owner/Data/RepoImp/MainOwnerRepoImpl.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Owner_dashbord/bloc/o_dash_bord_bloc.dart';
import 'package:garage/core/Error/Error.dart';

part 'owner_history_bloc_event.dart';
part 'owner_history_bloc_state.dart';

class OwnerHistoryBlocBloc
    extends Bloc<OwnerHistoryBlocEvent, OwnerHistoryBlocState> {
  BookingRepoImpl _bookingRepoImpl = BookingRepoImpl();
  OwnerHistoryBlocBloc() : super(OwnerHistoryBlocInitial()) {
    on<GetOwnerHistoryList>(_GetOwnerHistoryList);
  }

  void _GetOwnerHistoryList(
    GetOwnerHistoryList event,
    Emitter<OwnerHistoryBlocState> emit,
  ) async {
    emit(Owner_Faild_LoadingHistorygList());
    try {
      final _Result = await _bookingRepoImpl.GetHistory();

      _Result.fold((l) {
        emit(Owner_LoadingHistorygList());
        Failure.handle(l.exp);
      }, (r) {
        if (r == null) {
          emit(Owner_No_Data_HistorygList());
        } else {
          emit(GotHistorygList(HistoryBookingList: r));
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
