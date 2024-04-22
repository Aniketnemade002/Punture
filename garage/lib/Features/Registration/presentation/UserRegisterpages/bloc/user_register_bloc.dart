import 'package:animate_do/animate_do.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:garage/Features/Registration/Data/RepoImpl/UserRegisterRepoImpl.dart';
import 'package:garage/Features/Registration/Validator/Address.dart';
import 'package:garage/Features/Registration/Validator/Location.dart' as l;
import 'package:garage/Features/Registration/Validator/Location.dart';
import 'package:garage/Features/Registration/Validator/MobailNo.dart';
import 'package:garage/Features/Registration/Validator/Name.dart';
import 'package:garage/Features/Registration/Validator/PINValidator.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:garage/core/Validations/EmailValidator.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  UserRegisterRepoImpl _userRegister = UserRegisterRepoImpl();
  // OwnerRegisterRepoImpl _ownerRegister = OwnerRegisterRepoImpl();

  UserRegisterBloc() : super(const UserRegisterState()) {
    on<NameChanged>(_Namechanged);
    on<EmailChanged>(_EmailChanged);
    on<MobileNoChanged>(_MobileNoChanged);
    on<VillageChanged>(_VillageChanged);
    on<PINChanged>(_PINChanged);
    on<ConfirmPINChanged>(_ConfirmPINChanged);
    on<RegisterSubmitted>(_RegisterSubmitted);
    on<GeoLocationChanged>(_GeoLocationChanged);
  }

  void _Namechanged(
    NameChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            name,
            state.email,
            state.mobileNo,
            state.village,
            state.pin,
            state.confirmpin,
            state.geoLocation,
          ],
        ),
      ),
    );
  }

  void _EmailChanged(
    EmailChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            state.name,
            email,
            state.mobileNo,
            state.village,
            state.pin,
            state.confirmpin,
            state.geoLocation,
          ],
        ),
      ),
    );
  }

  void _MobileNoChanged(
    MobileNoChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    final mobileNo = MobileNumber.dirty(event.mobileNo);
    emit(
      state.copyWith(
        mobileNo: mobileNo,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            state.name,
            state.email,
            mobileNo,
            state.village,
            state.pin,
            state.confirmpin,
            state.geoLocation,
          ],
        ),
      ),
    );
  }

  void _VillageChanged(
    VillageChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    final village = Address.dirty(event.village);
    emit(
      state.copyWith(
        village: village,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            state.mobileNo,
            state.name,
            state.geoLocation,
            state.email,
            state.pin,
            state.confirmpin,
            village
          ],
        ),
      ),
    );
  }

  void _GeoLocationChanged(
    GeoLocationChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    final geoLocation = l.GeoPointInput.dirty(event.geoLocation);
    print(
        "Your Geo Locations ${geoLocation.value.latitude} and ${geoLocation.value.longitude}");
    emit(
      state.copyWith(
        geoLocation: geoLocation,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            state.mobileNo,
            state.name,
            geoLocation,
            state.email,
            state.pin,
            state.confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _PINChanged(
    PINChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    final pin = PIN.dirty(event.pin);
    final confirmpin =
        ConfirmPIN.dirty(originalPIN: event.pin, value: state.confirmpin.value);
    emit(
      state.copyWith(
        confirmpin: confirmpin,
        pin: pin,
        status: FormzSubmissionStatus.initial,
        isvalid: Formz.validate(
          [
            state.mobileNo,
            state.name,
            state.geoLocation,
            state.email,
            pin,
            confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _ConfirmPINChanged(
    ConfirmPINChanged event,
    Emitter<UserRegisterState> emit,
  ) {
    final confirmpin =
        ConfirmPIN.dirty(originalPIN: state.pin.value, value: event.confirmpin);
    emit(
      state.copyWith(
        confirmpin: confirmpin,
        isvalid: Formz.validate(
          [
            state.mobileNo,
            state.name,
            state.geoLocation,
            state.email,
            state.pin,
            confirmpin,
            state.village
          ],
        ),
      ),
    );
  }

  void _RegisterSubmitted(
    RegisterSubmitted event,
    Emitter<UserRegisterState> emit,
  ) async {
    if (state.isvalid) {
      emit(state.copyWith(
          isProfileCompleted: true,
          fcm: FCMtoken,
          wallet: 0,
          status: FormzSubmissionStatus.inProgress));
      try {
        final result = await _userRegister.UserRegister(
            fcm: state.fcm.trim(),
            village: state.village.value.trim(),
            wallet: state.wallet,
            isProfileCompleted: state.isProfileCompleted,
            name: state.name.value.trim(),
            email: state.email.value.trim(),
            mobileNo: state.mobileNo.value ?? 0,
            geoLocation: GeoPoint(state.geoLocation.value.latitude,
                state.geoLocation.value.longitude),
            pin: int.parse(state.pin.value.trim()));

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
