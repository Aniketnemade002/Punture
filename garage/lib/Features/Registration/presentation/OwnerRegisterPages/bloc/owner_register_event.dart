part of 'owner_register_bloc.dart';

sealed class OwnerRegisterEvent extends Equatable {
  const OwnerRegisterEvent();

  @override
  List<Object> get props => [];
}

class GarageNameChanged extends OwnerRegisterEvent {
  final String GarageName;
  const GarageNameChanged(this.GarageName);

  @override
  List<Object> get props => [GarageName];
}

class fullAddressChanged extends OwnerRegisterEvent {
  final String fullAddress;
  const fullAddressChanged(this.fullAddress);

  @override
  List<Object> get props => [fullAddress];
}

class OwnerNameChanged extends OwnerRegisterEvent {
  final String OwnerName;
  const OwnerNameChanged(this.OwnerName);

  @override
  List<Object> get props => [OwnerName];
}

class EmailChanged extends OwnerRegisterEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class MobileNoChanged extends OwnerRegisterEvent {
  final int mobileNo;
  const MobileNoChanged(this.mobileNo);

  @override
  List<Object> get props => [mobileNo];
}

class ServiceCostChanged extends OwnerRegisterEvent {
  final int ServiceCost;
  const ServiceCostChanged(this.ServiceCost);

  @override
  List<Object> get props => [ServiceCost];
}

class VillageChanged extends OwnerRegisterEvent {
  final String village;
  const VillageChanged(this.village);

  @override
  List<Object> get props => [village];
}

class GeoLocationChanged extends OwnerRegisterEvent {
  final GeoPoint geoLocation;
  const GeoLocationChanged(this.geoLocation);

  @override
  List<Object> get props => [geoLocation];
}

class PINChanged extends OwnerRegisterEvent {
  final String pin;
  const PINChanged(this.pin);
  @override
  List<Object> get props => [pin];
}

class ConfirmPINChanged extends OwnerRegisterEvent {
  final String confirmpin;
  const ConfirmPINChanged(this.confirmpin);
  @override
  List<Object> get props => [confirmpin];
}

final class RegisterSubmitted extends OwnerRegisterEvent {}
