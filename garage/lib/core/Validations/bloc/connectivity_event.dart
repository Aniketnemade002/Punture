part of 'connectivity_bloc.dart';

@immutable
sealed class ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult connectivityResult;

  ConnectivityChanged(this.connectivityResult);
}
