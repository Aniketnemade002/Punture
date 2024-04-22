import 'package:fpdart/fpdart.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';

import 'package:garage/core/Error/Error.dart';

abstract interface class MainUserRepo {
  Future<Either<Fail, MainUserModal?>> GetUser();
}
