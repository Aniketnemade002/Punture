import 'package:fpdart/src/either.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';
import 'package:garage/Features/user/Data/Source/Remote_MainUser.dart';
import 'package:garage/Features/user/Data/Source/Remote_UserBookings.dart';

import 'package:garage/Features/user/Domain/Repo/MainUserRepo.dart';
import 'package:garage/core/Error/Error.dart';

class MainUserRepoImpl implements MainUserRepo {
  mainUserDataSourceImpl _userDataSourceImpl = mainUserDataSourceImpl();
  UserBookingDataRepoImpl _userBookingDataRepoImpl = UserBookingDataRepoImpl();
  @override
  Future<Either<Fail, MainUserModal?>> GetUser() async {
    try {
      final result = await _userDataSourceImpl.GetUser();

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}

class UserBookingDataRepoImpl implements UserBookingsDataRepo {
  UserBookingDataSourseImpl _userBookingDataSourseImpl =
      UserBookingDataSourseImpl();

  @override
  Future<Either<Fail, List<UserBookingDataModal>?>> GetBookings() async {
    try {
      print('+++++++++++++++++++ Booking Requested MIddele Repo +++++++');
      final result = await _userBookingDataSourseImpl.GetBookings();

      if (result == null) {
        return right(result);
      }

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}

class UserBookingHistoryRepoImpl implements UserBookingHistoryRepo {
  UserBookingDataSourseImpl _userBookingDataSourseImpl =
      UserBookingDataSourseImpl();
  @override
  Future<Either<Fail, List<UserHistoryModal>?>> GetHistory() async {
    try {
      final result = await _userBookingDataSourseImpl.GetHistory();
      if (result == null) {
        return right(result);
      }

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }
}
