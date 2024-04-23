import 'package:fpdart/fpdart.dart';
import 'package:garage/Payment/Data/Remote_Paymet.dart';
import 'package:garage/core/Error/Error.dart';

class OwnerPaymentRepo {
  OwnerPaymentDataSource _paymentDataSource = OwnerPaymentDataSource();

  Future<Either<Fail, bool>> toBank(int Ammount) async {
    try {
      final result = await _paymentDataSource.WithadreawPay(Ammount);
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  Future<Either<Fail, int>> Get() async {
    try {
      final result = await _paymentDataSource.Get();
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}

class UserPaymentRepo {
  UserPaymentDataSource _paymentDataSource = UserPaymentDataSource();

  Future<Either<Fail, bool>> Pay(int Ammount) async {
    try {
      final result = await _paymentDataSource.Pay(Ammount);

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  Future<Either<Fail, int>> Get() async {
    try {
      final result = await _paymentDataSource.Get();

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}
