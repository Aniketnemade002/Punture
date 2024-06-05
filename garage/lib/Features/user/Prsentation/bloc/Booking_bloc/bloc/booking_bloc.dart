import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:garage/Features/Registration/Validator/Address.dart';
import 'package:garage/Features/Registration/Validator/Name.dart';
import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
import 'package:garage/Features/user/Data/RepoImp/BookingRepoImpl.dart';
import 'package:garage/Features/user/Data/RepoImp/MainUserImpl.dart';
import 'package:garage/Features/user/Domain/Entity/UserModal.dart';
import 'package:garage/Payment/Data/Remote_Paymet.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/core/Error/Error.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingSystemRepoImpl _bookingSystemRepoImpl = BookingSystemRepoImpl();
  UserPaymentDataSource _userPaymentDataSource = UserPaymentDataSource();
  MainUserRepoImpl _MainUserRepoImpl = MainUserRepoImpl();

  BookingBloc() : super(BookingState()) {
    on<GetSlot>(_GetSlot);
    on<AddBooking>(_AddBooking);
    on<GetGarages>(_GetGarages);
    on<vehical_No_Change>(_vehical_No_Change);
    on<DiscriptionChange>(_DiscriptionChange);
    on<SelectSlot>(_SelectSlot);
  }

  void _SelectSlot(
    SelectSlot event,
    Emitter<BookingState> emit,
  ) {
    emit(
      state.copyWith(
        SlotID: event.SlotID,
      ),
    );
  }

  void _vehical_No_Change(
    vehical_No_Change event,
    Emitter<BookingState> emit,
  ) {
    final vehicalNo = GarageName.dirty(event.Vehical_No);
    emit(
      state.copyWith(
        vehicalNo: vehicalNo,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate(
          [vehicalNo, state.Discription],
        ),
      ),
    );
  }

  void _DiscriptionChange(
    DiscriptionChange event,
    Emitter<BookingState> emit,
  ) {
    final Discription = FullAddress.dirty(event.Discription);
    emit(
      state.copyWith(
        discription: Discription,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate(
          [state.Vehical_No, Discription],
        ),
      ),
    );
  }

  void _GetGarages(
    GetGarages event,
    Emitter<BookingState> emit,
  ) async {
    emit(Loading());
    try {
      final result = await _bookingSystemRepoImpl.GetGarages(event.VillageName);

      result.fold((l) {
        Failure.handle(l.exp);
        emit(FeatchedGaragesFaild());
      }, (r) {
        if (r == []) {
          emit(NoDataGarage());
        } else {
          if (r != null) {
            emit(FeatchedGarages(GarageList: r));
          } else {
            emit(FeatchedGaragesFaild());
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ///
  ///
  ///
  ///
  ///
  ///
  //
  void _AddBooking(
    AddBooking event,
    Emitter<BookingState> emit,
  ) async {
    final UserTemp = await _MainUserRepoImpl.GetUser();

    UserTemp.fold((l) {
      emit(FeatchedGaragesFaild());
    }, (UserResult) async {
      if (UserResult == null) {
        emit(FeatchedGaragesFaild());
      } else {
        emit(FeatchedGaragesLoading());

        if (UserResult.wallet < event.serviceCost) {
          emit(LowBalence());
        } else {
          if (state.isValid) {
            emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
            emit(state.copyWith(
                owneruid: event.owneruid,
                garageName: event.garageName,
                ownername: event.ownername,
                OwnerMobileNo: event.OwnerMobileNo,
                serviceCost: event.serviceCost,
                GarageLocation: event.GarageLocation,
                SlotID: event.SlotID,
                address: event.address,
                username: UserResult.name,
                useruid: UserResult.uid,
                userMobileNo: UserResult.mobileNo,
                CurrentLocation: event.CurrentLocation,
                status: FormzSubmissionStatus.inProgress));
            try {
              final result = await _bookingSystemRepoImpl.DoBookeSlot(
                  owneruid: state.owneruid,
                  garageName: state.garageName,
                  ownername: state.ownername,
                  OwnerMobileNo: state.OwnerMobileNo,
                  serviceCost: state.serviceCost,
                  GarageLocation: state.GarageLocation,
                  Address: state.address,
                  SlotTime: event.SlotTime,
                  username: state.username,
                  SlotID: state.SlotID,
                  useruid: state.useruid,
                  Discription: state.Discription.value.trim(),
                  Vehical_No: state.Vehical_No.value.trim(),
                  userMobileNo: state.userMobileNo,
                  CurrentLocation: state.CurrentLocation);

              result.fold(
                (l) {
                  Failure.handle(l.exp);
                  emit(state.copyWith(status: FormzSubmissionStatus.failure));
                },
                (r) => r == true
                    ? emit(
                        state.copyWith(status: FormzSubmissionStatus.success))
                    : emit(
                        state.copyWith(status: FormzSubmissionStatus.failure)),
              );
            } catch (e) {}
          } else {
            emit(state.copyWith(status: FormzSubmissionStatus.failure));
          }
        }
      }
    });
  }

  void _GetSlot(
    GetSlot event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(FeatchedSlotListLoading());
      final result = await _bookingSystemRepoImpl.GetTimeSlots(event.OwnerId);

      result.fold((l) {
        Failure.handle(l.exp);
        emit(FeatchedSlotListFaild());
      }, (r) {
        if (r == []) {
          emit(NoDataSlot());
        } else {
          if (r != null) {
            emit(FeatchedSlotList(SlotList: r));
          } else {
            emit(FeatchedSlotListFaild());
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
