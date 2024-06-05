import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/core/Error/Error.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepoImpl _auth;
  late StreamSubscription<AuthenticationStatus> _authStatusSubscription;

  AuthBloc({
    required AuthRepoImpl authenticationRepository,
  })  : _auth = authenticationRepository,
        super(const AuthState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationSetUser>(_onAuthenticationSetUser);

    _authStatusSubscription = _auth.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    _auth.dispose();

    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event, Emitter<AuthState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final result = await _auth.islogedin();
        result.fold(
          (l) {
            Failure.handle(l.exp);
            return const AuthState.unauthenticated();
          },
          (r) => r == true
              ? AuthState.authenticated(r)
              : const AuthState.unauthenticated(),
        );

      case AuthenticationStatus.unknown:
        return emit(const AuthState.unknown());
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event, Emitter<AuthState> emit) async {
    _auth.Logout();
  }

//  context
//                           .read<AuthenticationBloc>()
//                           .add(AuthenticationLogoutRequested());
//                       Future.delayed(Duration.zero, () async {
//                         Navigator.of(context).pushAndRemoveUntil(
//                           MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 const LoginOption(),
//                           ),
//                           (Route route) => false,
//                         );
//                       });

  void _onAuthenticationSetUser(
      AuthenticationSetUser event, Emitter<AuthState> emit) {
    emit(AuthState.authenticated(event.isLogin));
  }
}
