import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:garage/core/Validations/EmailValidator.dart';
import 'package:garage/core/Validations/PasswordValidator.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepoImpl _auth = AuthRepoImpl();

  LoginBloc() : super(LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      final email = Email.dirty(event.email);
      emit(
        state.copyWith(
          email: email,
          status: FormzSubmissionStatus.initial,
          isValid: Formz.validate(
            [email, state.password],
          ),
        ),
      );
    });
    on<LoginPasswordChanged>((event, emit) {
      final password = Password.dirty(event.password);

      emit(state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.email, password]),
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.isValid) {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        try {
          final result = await _auth.Login(
              email: state.email.value.trim(),
              password: state.password.value.trim());

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
    });
  }
}
