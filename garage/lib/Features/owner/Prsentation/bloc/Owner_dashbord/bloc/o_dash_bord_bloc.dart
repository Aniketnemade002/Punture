import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
import 'package:garage/Features/owner/Data/RepoImp/MainOwnerRepoImpl.dart';
import 'package:garage/core/Error/Error.dart';

part 'o_dash_bord_event.dart';
part 'o_dash_bord_state.dart';

class ODashBordBloc extends Bloc<ODashBordEvent, ODashBordState> {
  MainOwnerRepoImpl _mainOwnerRepoImpl = MainOwnerRepoImpl();
  BookingRepoImpl _bookingRepoImpl = BookingRepoImpl();
  ODashBordBloc() : super(ODashBordInitial()) {
    on<GetOwner>(_GetOwner);
    on<GetOwnerBookingList>(_GetOwnerBookingList);
    on<GetOwnerHistoryList>(_GetOwnerHistoryList);
    on<InitializeBloc>(_InitializeBloc);
    on<GetDelete_service>(_GetDelete_service);
  }
  void _InitializeBloc(
    InitializeBloc event,
    Emitter<ODashBordState> emit,
  ) async {
    emit(Initial());
  }

  void _GetDelete_service(
    GetDelete_service event,
    Emitter<ODashBordState> emit,
  ) async {
    emit(Delete_service_Loading());
    try {
      final _Result = await _bookingRepoImpl.ReleasedAndDeleteSlot(
          BookingId: event.BookingId,
          owneruid: event.owneruid,
          garageName: event.garageName,
          ownername: event.ownername,
          OwnerMobileNo: event.OwnerMobileNo,
          serviceCost: event.serviceCost,
          GarageLocation: event.GarageLocation,
          Address: event.Address,
          SlotTime: event.SlotTime,
          SlotID: event.SlotID,
          username: event.username,
          useruid: event.useruid,
          Discription: event.Discription,
          Vehical_No: event.Vehical_No,
          userMobileNo: event.userMobileNo,
          CurrentLocation: event.CurrentLocation);
      _Result.fold((l) {
        emit(Delete_service_Faild());
        Failure.handle(l.exp);
      }, (r) {
        if (r == true) {
          emit(Delete_service_sucsess());
        } else {
          emit(Delete_service_Faild());
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _GetOwner(
    GetOwner event,
    Emitter<ODashBordState> emit,
  ) async {
    emit(OwnerLoading());
    try {
      final _Result = await _mainOwnerRepoImpl.GetOwner();

      _Result.fold((l) {
        emit(OwnerLoadFaild());
        Failure.handle(l.exp);
      }, (r) {
        if (r == null) {
          emit(OwnerLoadFaild());
        } else {
          emit(GotOwner(owner: r));
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _GetOwnerBookingList(
    GetOwnerBookingList event,
    Emitter<ODashBordState> emit,
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

  void _GetOwnerHistoryList(
    GetOwnerHistoryList event,
    Emitter<ODashBordState> emit,
  ) async {
    emit(Owner_LoadingFaild_LoadingHistorygList());
    try {
      final _Result = await _bookingRepoImpl.GetHistory();

      _Result.fold((l) {
        emit(Owner_Faild_BookingList());
        Failure.handle(l.exp);
      }, (r) {
        if (r == null) {
          emit(Owner_NoData_BookingList());
        } else {
          emit(GotHistorygList(HistoryBookingList: r));
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
