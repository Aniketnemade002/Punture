import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garage/Payment/Repo/PaymentRepo.dart';
import 'package:garage/Payment/ammountvalidaotr.dart';
import 'package:garage/constant/constant.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/core/Error/Error.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  OwnerPaymentRepo _ownerPaymentRepo = OwnerPaymentRepo();
  UserPaymentRepo _userPaymentRepo = UserPaymentRepo();

  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentRequested>(_onPaymentRequested);
    on<UserFetchBalance>(_UserFetchBalance);
    on<OwnerFetchBalance>(_OwnerFetchBalance);
    on<WithdrawAmmount>(_onWithdrawAmmount);
  }

  void _OwnerFetchBalance(
    OwnerFetchBalance event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      final result = await _ownerPaymentRepo.Get();

      result.fold((l) {
        Failure.handle(l.exp);
        emit(PaymentFailure());
      }, (r) => emit(BalanceLoaded(r)));
    } catch (e) {
      emit(BalanceLoadFailure());
    }
  }

  void _UserFetchBalance(
    UserFetchBalance event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      final result = await _userPaymentRepo.Get();

      result.fold((l) {
        Failure.handle(l.exp);
        emit(PaymentFailure());
      }, (r) => emit(BalanceLoaded(r)));
    } catch (e) {
      emit(BalanceLoadFailure());
    }
  }

  void _onWithdrawAmmount(
    WithdrawAmmount event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());

    try {
      final result = await _ownerPaymentRepo.toBank(event.amount);

      result.fold(
        (l) {
          Failure.handle(l.exp);
          emit(WithdrawFailure());
        },
        (r) {
          if (r) {
            emit(DoneWithdraw(event.amount));
          } else {
            emit(WithdrawFailure());
          }
        },
      );
    } catch (e) {
      emit(WithdrawFailure());
    }
  }

  void _onPaymentRequested(
    PaymentRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());

    try {
      final result = await _userPaymentRepo.Pay(event.amount);
      result.fold(
        (l) {
          Failure.handle(l.exp);
          emit(PaymentFailure());
        },
        (r) {
          if (r) {
            emit(PaymentSuccess(event.amount));
          } else {
            emit(PaymentFailure());
          }
        },
      );
    } catch (e) {
      emit(PaymentFailure());
    }
  }
}
