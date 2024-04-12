import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:meta/meta.dart';
import 'dart:async';
part 'email_verify_state.dart';

enum EmailVerifyEvent { checkEmailVerification, resendEmail }

class VerificationBloc extends Bloc<EmailVerifyEvent, VerificationState> {
  AuthRepoImpl _authRepoImpl = AuthRepoImpl();
  Timer? _timer;
  Timer? _resendTimer;

  VerificationBloc() : super(VerificationInitial()) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    on<EmailVerifyEvent>((event, emit) async {
      if (event == EmailVerifyEvent.checkEmailVerification) {
        emit(VerificationLoading());

        await _auth.currentUser!.reload();
        _timer = Timer.periodic(Duration(seconds: 5), (_) async {
          await _auth.currentUser!.reload();
          var user = _auth.currentUser;
          if (user != null && user.emailVerified) {
            _timer?.cancel();
            emit(VerificationVerified());
          } else {
            emit(VerificationNotVerified(
                canResendEmail: _resendTimer?.isActive ?? false));
          }
        });

        _resendTimer = Timer(Duration(seconds: 30), () {
          emit(VerificationNotVerified(canResendEmail: true));
        });
      } else if (event == EmailVerifyEvent.resendEmail) {
        await _authRepoImpl.SendVerificationEmail;
        emit(VerificationNotVerified(canResendEmail: false));
        _resendTimer = Timer(Duration(seconds: 30), () {
          emit(VerificationNotVerified(canResendEmail: true));
        });
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _resendTimer?.cancel();
    return super.close();
  }
}
