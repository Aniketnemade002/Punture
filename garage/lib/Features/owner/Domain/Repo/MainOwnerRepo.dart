import 'package:fpdart/fpdart.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
import 'package:garage/core/Error/Error.dart';

abstract interface class MainOwnerRepo {
  Future<Either<Fail, MainOwnerModal?>> GetOwner();
}
