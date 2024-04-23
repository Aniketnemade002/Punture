part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentFailure extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final int amount;

  const PaymentSuccess(this.amount);

  @override
  List<Object> get props => [amount];
}

class BalanceLoaded extends PaymentState {
  final int amount;

  const BalanceLoaded(this.amount);

  @override
  List<Object> get props => [amount];
}

class DoneWithdraw extends PaymentState {
  final int amount;

  const DoneWithdraw(this.amount);

  @override
  List<Object> get props => [amount];
}

class WithdrawFailure extends PaymentState {}

class BalanceLoadFailure extends PaymentState {}
