import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:garage/Features/Registration/Validator/Address.dart';
import 'package:garage/Features/Registration/Validator/Name.dart';
import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';
import 'package:garage/Features/user/Data/RepoImp/BookingRepoImpl.dart';
import 'package:garage/Features/user/Data/RepoImp/MainUserImpl.dart';
import 'package:garage/Features/user/Domain/Entity/UserModal.dart';
import 'package:garage/Features/user/Prsentation/bloc/Booking_bloc/Constant_BOOKING.dart';
import 'package:garage/Payment/Data/Remote_Paymet.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/core/Error/Error.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingSystemRepoImpl _bookingSystemRepoImpl = BookingSystemRepoImpl();
  UserPaymentDataSource _userPaymentDataSource = UserPaymentDataSource();
  MainUserRepoImpl _MainUserRepoImpl = MainUserRepoImpl();
  late String VH;
  late String D;
  late MainUserModal R;

  BookingBloc() : super(BookingState()) {
    on<GetSlot>(_GetSlot);
    on<AddBooking>(_AddBooking);
    on<GetGarages>(_GetGarages);
    on<vehical_No_Change>(_vehical_No_Change);
    on<DiscriptionChange>(_DiscriptionChange);
    on<SelectSlot>(_SelectSlot);
    on<initial>(_initial);
  }
  void _initial(
    initial event,
    Emitter<BookingState> emit,
  ) {
    emit(initializ());
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
    print('');
    VH = vehicalNo.value;

    print('++++++++Discription is ++++++++++ ${vehicalNo.value} ');
    print('++++ State of V-NO  ++++++++++ ${state.Discription.value}  ');

    print('');
    emit(
      state.copyWith(
        vehicalNo: vehicalNo,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate(
          [vehicalNo, state.Discription],
        ),
      ),
    );
    print('++++ New  ++++++++++ ${VH}  ');
  }

  void _DiscriptionChange(
    DiscriptionChange event,
    Emitter<BookingState> emit,
  ) {
    final Discription = FullAddress.dirty(event.Discription);
    D = Discription.value;
    print('++++++Discription is ++++++++++ ${Discription.value}  ');
    print(' +++State of V-NO  ++++++++++ ${state.Vehical_No.value}  ');
    print('');
    print('');

    emit(
      state.copyWith(
        discription: Discription,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate(
          [state.Vehical_No, Discription],
        ),
      ),
    );
    print('++++++ New Discription is ++++++++++ ${D}  ');
    print('');
    print('');
  }

  void _GetGarages(
    GetGarages event,
    Emitter<BookingState> emit,
  ) async {
    print('++++++++++++++++++++Getting Garreges++++++++++');
    emit(Loading());
    try {
      final result = await _bookingSystemRepoImpl.GetGarages(event.VillageName);

      result.fold((l) {
        Failure.handle(l.exp);
        emit(FeatchedGaragesFaild());
      }, (r) {
        if (r == null) {
          print('++++++++++++++++++++ Noooo Getting Found++++++++++');
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
    print('');
    print('');
    print('');
    print('');
    print('');
    print('++++++Discription is ++++++++++ ${state.Discription.value}  ');
    print(' +++State of V-NO  ++++++++++ ${state.Vehical_No.value}  ');
    print('');
    print('');
    print(' +++IS Valid  ++++++++++ ${state.isValid}  ');
    print('');

    final UserTemp = await _MainUserRepoImpl.GetUser();

    UserTemp.fold((l) {
      emit(FeatchedGaragesFaild());
    }, (UserResult) {
      if (UserResult == null) {
        emit(FeatchedGaragesFaild());
      } else {
        R = UserResult;
      }
    });

    emit(state.copyWith(status: FormzSubmissionStatus.initial));

    if (R.wallet < event.serviceCost) {
      blencelow = true;
      emit(LowBalence());
    } else {
      print('');
      print('');
      print('');
      print('');
      print('');
      print('++++++Discription is ++++++++++ ${state.Discription.value}  ');
      print(' +++State of V-NO  ++++++++++ ${state.Vehical_No.value}  ');
      print('');
      print('');
      print(' +++IS Valid  ++++++++++ ${state.isValid}  ');
      print('');

      if (state.isValid) {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        print(' +++Oyyyyyy ++++++++++ ${state.isValid}  ');
        try {
          final result = await _bookingSystemRepoImpl.DoBookeSlot(
              owneruid: event.owneruid,
              garageName: event.garageName,
              ownername: event.ownername,
              OwnerMobileNo: event.OwnerMobileNo,
              serviceCost: event.serviceCost,
              GarageLocation: event.GarageLocation,
              Address: event.address,
              SlotTime: event.SlotTime,
              username: R.name,
              SlotID: state.SlotID,
              useruid: R.uid,
              Discription: state.Discription.value.trim(),
              Vehical_No: state.Vehical_No.value.trim(),
              userMobileNo: R.mobileNo,
              CurrentLocation: event.CurrentLocation);

          result.fold((l) {
            BookingFaild = true;
            Failure.handle(l.exp);
            emit(state.copyWith(status: FormzSubmissionStatus.failure));
          }, (r) {
            print(' +++Oyyyyyy ++++++++++ SuCSESSS+++++++++++++++  ');
            BookingSuccess = true;

            emit(state.copyWith(status: FormzSubmissionStatus.success));
          });
        } catch (e) {}
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  void _GetSlot(
    GetSlot event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(FeatchedSlotListLoading());
      print('++++++++++++++++++++Getting Slots++++++++++');
      final result = await _bookingSystemRepoImpl.GetTimeSlots(event.OwnerId);

      result.fold((l) {
        Failure.handle(l.exp);
        emit(FeatchedSlotListFaild());
      }, (r) {
        if (r == null) {
          print('++++++++++++++++++++Getting Null3++++++++++');
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
