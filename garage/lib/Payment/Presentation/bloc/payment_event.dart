part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentRequested extends PaymentEvent {
  final int amount;

  const PaymentRequested(this.amount);

  @override
  List<Object> get props => [amount];
}

class OwnerFetchBalance extends PaymentEvent {}

class UserFetchBalance extends PaymentEvent {}

class WithdrawAmmount extends PaymentEvent {
  final int amount;

  const WithdrawAmmount(this.amount);

  @override
  List<Object> get props => [amount];
}
