part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class _AuthenticationStatusChanged extends AuthEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationSetUser extends AuthEvent {
  const AuthenticationSetUser(this.isLogin);

  final bool isLogin;

  @override
  List<Object> get props => [isLogin];
}

class AuthenticationLogoutRequested extends AuthEvent {}
