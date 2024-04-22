part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthenticationStatus status;
  final bool isLogin;
  const AuthState._(
      {this.status = AuthenticationStatus.unknown, this.isLogin = false});

  const AuthState.unknown() : this._();

  const AuthState.authenticated(bool isLogin)
      : this._(status: AuthenticationStatus.authenticated, isLogin: isLogin);

  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, isLogin];
}
