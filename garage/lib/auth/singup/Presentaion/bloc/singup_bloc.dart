import 'package:bloc/bloc.dart';
import 'package:garage/auth/Data/RepoImp/SingUpRepoImpl.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:garage/core/Validations/EmailValidator.dart';
import 'package:garage/core/Validations/PasswordValidator.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
part 'singup_event.dart';
part 'singup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignUpRepoImpl _signUpRepoImpl = SignUpRepoImpl();
  SignupBloc() : super(const SignupState()) {
    on<SignupEmailChanged>((event, emit) {
      final email = Email.dirty(event.email);
      emit(
        state.copyWith(
          email: email,
          status: FormzSubmissionStatus.initial,
          isValid: Formz.validate(
            [email, state.password, state.confirmPassword],
          ),
        ),
      );
    });

    on<SignupPasswordChanged>((event, emit) {
      final password = Password.dirty(event.password);
      final confirmPassword = ConfirmPassword.dirty(
          password: event.password, value: state.confirmPassword.value);
      emit(state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.email, password, confirmPassword]),
      ));
    });

    on<SignupConfirmPasswordChanged>(
      (event, emit) {
        final confirmPassword = ConfirmPassword.dirty(
            password: state.password.value, value: event.password);
        emit(state.copyWith(
          confirmPassword: confirmPassword,
          isValid:
              Formz.validate([state.email, state.password, confirmPassword]),
        ));
      },
    );

    on<SignupSubmitted>(
      (event, emit) async {
        if (state.isValid) {
          emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
          if (isuser) {
            try {
              final result = await _signUpRepoImpl.UserSingUp(
                  email: state.email.value.trim(),
                  password: state.confirmPassword.value.trim());

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
            try {
              final result = await _signUpRepoImpl.OwnerSingUp(
                  email: state.email.value.trim(),
                  password: state.confirmPassword.value.trim());

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
          }
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      },
    );
  }
}
