import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:garage/Features/Registration/Data/RepoImpl/OwnerRegisterRepoImpl.dart';
import 'package:garage/Features/Registration/Validator/Address.dart';
import 'package:garage/Features/Registration/Validator/Location.dart' as l;

import 'package:garage/Features/Registration/Validator/MobailNo.dart';
import 'package:garage/Features/Registration/Validator/Name.dart';
import 'package:garage/Features/Registration/Validator/PINValidator.dart';
import 'package:garage/Features/Registration/Validator/ServiceCost.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:garage/core/Validations/EmailValidator.dart';

part 'owner_register_event.dart';
part 'owner_register_state.dart';

class OwnerRegisterBloc extends Bloc<OwnerRegisterEvent, OwnerRegisterState> {
  OwnerRegisterRepoImpl _ownerRegister = OwnerRegisterRepoImpl();

  OwnerRegisterBloc() : super(OwnerRegisterState()) {
    on<GarageNameChanged>(_GarageNameChanged);
    on<ServiceCostChanged>(_ServiceCostChanged);
    on<OwnerNameChanged>(_OwnerNameChanged);
    on<EmailChanged>(_EmailChanged);
    on<MobileNoChanged>(_MobileNoChanged);
    on<VillageChanged>(_VillageChanged);
    on<PINChanged>(_PINChanged);
    on<ConfirmPINChanged>(_ConfirmPINChanged);
    on<RegisterSubmitted>(_RegisterSubmitted);
    on<fullAddressChanged>(_fullAddressChanged);
  }

  void _GarageNameChanged(
    GarageNameChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final garageName = GarageName.dirty(event.GarageName);
    emit(
      state.copyWith(
        garageName: garageName,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            garageName,
            state.fullAddress,
            state.ownername,
            state.serviceCost,
            state.geoLocation,
            state.email,
            state.mobileNo,
            state.pin,
            state.confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _OwnerNameChanged(
    OwnerNameChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final ownername = Name.dirty(event.OwnerName);
    emit(
      state.copyWith(
        ownername: ownername,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            ownername,
            state.fullAddress,
            state.garageName,
            state.serviceCost,
            state.geoLocation,
            state.email,
            state.mobileNo,
            state.pin,
            state.confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _ServiceCostChanged(
    ServiceCostChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final serviceCost = ServiceCost.dirty(event.ServiceCost);
    emit(
      state.copyWith(
        serviceCost: serviceCost,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            serviceCost,
            state.fullAddress,
            state.garageName,
            state.ownername,
            state.geoLocation,
            state.email,
            state.mobileNo,
            state.pin,
            state.confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _EmailChanged(
    EmailChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            state.serviceCost,
            state.fullAddress,
            state.garageName,
            state.ownername,
            state.geoLocation,
            email,
            state.mobileNo,
            state.pin,
            state.confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _MobileNoChanged(
    MobileNoChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final mobilenumber = MobileNumber.dirty(event.mobileNo);
    emit(
      state.copyWith(
        mobileNo: mobilenumber,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            mobilenumber,
            state.fullAddress,
            state.serviceCost,
            state.garageName,
            state.ownername,
            state.geoLocation,
            state.email,
            state.pin,
            state.confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _VillageChanged(
    VillageChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final vilage = Address.dirty(event.village);
    emit(
      state.copyWith(
        village: vilage,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            state.mobileNo,
            state.fullAddress,
            state.serviceCost,
            state.garageName,
            state.ownername,
            state.geoLocation,
            state.email,
            state.pin,
            state.confirmpin,
            vilage
          ],
        ),
      ),
    );
  }

  void _PINChanged(
    PINChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final pin = PIN.dirty(event.pin);
    final Confirmpin =
        ConfirmPIN.dirty(originalPIN: event.pin, value: state.confirmpin.value);
    emit(
      state.copyWith(
        confirmpin: Confirmpin,
        pin: pin,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            state.mobileNo,
            state.serviceCost,
            state.fullAddress,
            state.garageName,
            state.ownername,
            state.geoLocation,
            Confirmpin,
            state.email,
            pin,
            state.village
          ],
        ),
      ),
    );
  }

  void _ConfirmPINChanged(
    ConfirmPINChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final confirmpin =
        ConfirmPIN.dirty(originalPIN: state.pin.value, value: event.confirmpin);
    emit(
      state.copyWith(
        confirmpin: confirmpin,
        isvalid: Formz.validate(
          [
            state.mobileNo,
            state.serviceCost,
            state.fullAddress,
            state.garageName,
            state.ownername,
            state.geoLocation,
            confirmpin,
            state.email,
            state.pin,
            state.village
          ],
        ),
      ),
    );
  }

  void _fullAddressChanged(
    fullAddressChanged event,
    Emitter<OwnerRegisterState> emit,
  ) {
    final fullAddress = FullAddress.dirty(event.fullAddress);
    emit(
      state.copyWith(
        fullAddress: fullAddress,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            fullAddress,
            state.serviceCost,
            state.garageName,
            state.ownername,
            state.geoLocation,
            state.email,
            state.pin,
            state.confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _RegisterSubmitted(
    RegisterSubmitted event,
    Emitter<OwnerRegisterState> emit,
  ) async {
    if (state.isvalid) {
      emit(state.copyWith(
          isProfileCompleted: true,
          fcm: FCMtoken,
          wallet: 0,
          SID: 0,
          status: FormzSubmissionStatus.inProgress));
      try {
        final result = await _ownerRegister.OwnerRegister(
            fcm: state.fcm.trim(),
            village: state.village.value.trim(),
            Address: state.fullAddress.value.trim(),
            ServiceCost: state.serviceCost.value ?? 0,
            wallet: state.wallet,
            isProfileCompleted: state.isProfileCompleted,
            OwnerName: state.ownername.value.trim(),
            GarageName: state.garageName.value.trim(),
            email: state.email.value.trim(),
            mobileNo: state.mobileNo.value ?? 0,
            geoLocation: GeoPoint(state.geoLocation.value.latitude,
                state.geoLocation.value.latitude),
            pin: int.parse(state.pin.value.trim()),
            SID: state.SID);

        result.fold(
          (l) {
            Failure.handle(l.exp);
            emit(state.copyWith(status: FormzSubmissionStatus.failure));
          },
          (r) => r == true
              ? emit(state.copyWith(status: FormzSubmissionStatus.success))
              : emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        );
      } catch (e) {}
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
