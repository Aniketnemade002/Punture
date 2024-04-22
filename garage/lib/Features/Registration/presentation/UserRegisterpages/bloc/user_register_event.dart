part of 'user_register_bloc.dart';

sealed class UserRegisterEvent extends Equatable {
  const UserRegisterEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends UserRegisterEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class EmailChanged extends UserRegisterEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class MobileNoChanged extends UserRegisterEvent {
  final int mobileNo;
  const MobileNoChanged(this.mobileNo);

  @override
  List<Object> get props => [mobileNo];
}

class VillageChanged extends UserRegisterEvent {
  final String village;
  const VillageChanged(this.village);

  @override
  List<Object> get props => [village];
}

class GeoLocationChanged extends UserRegisterEvent {
  final GeoPoint geoLocation;
  const GeoLocationChanged(this.geoLocation);

  @override
  List<Object> get props => [geoLocation];
}

class PINChanged extends UserRegisterEvent {
  final String pin;
  const PINChanged(this.pin);
  @override
  List<Object> get props => [pin];
}

class ConfirmPINChanged extends UserRegisterEvent {
  final String confirmpin;
  const ConfirmPINChanged(this.confirmpin);
  @override
  List<Object> get props => [confirmpin];
}

final class RegisterSubmitted extends UserRegisterEvent {}
