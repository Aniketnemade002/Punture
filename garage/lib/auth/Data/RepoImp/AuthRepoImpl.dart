import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/auth/Data/Source/Remote_User.dart';
import 'package:garage/auth/Domain/Eintity/LoginResponse.dart';
import 'package:garage/auth/Domain/Repo/authrepo.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthRepoImpl implements AuthRepo {
  final UserDataSourceImpl user = UserDataSourceImpl();
  final _storage = storage;

  final _controller = StreamController<AuthenticationStatus>();
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  @override
  Future<Either<Fail, LoginResponse?>> Login(
      {required String email, required String password}) async {
    try {
      final loginResponce = await user.LogIn(email: email, password: password);

      if (loginResponce != null) {
        await _storage.write(key: 'Uid', value: loginResponce.Uid);
        _storage.write(
            key: 'S_UserEntity', value: isuser == true ? 'USER' : 'OWNER');
        UserUid = loginResponce.Uid;
        await _storage.write(
            key: 'LoginInfo', value: json.encode(loginResponce));
        if (loginResponce.isverified) {
          _storage.write(key: 'isUserVerified', value: 'yes');
        }
        if (loginResponce.isProfileCompleted) {
          await _storage.write(key: 'isProfileCompleted', value: 'yes');
        }
        _controller.add(AuthenticationStatus.authenticated);
        return right(loginResponce);
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
        return right(null);
      }
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  @override
  Future<void> Logout() async {
    try {
      await user.Logout();
      await _storage.deleteAll();
      _controller.add(AuthenticationStatus.unauthenticated);
    } on Exp catch (e) {
      Fail(exp: e);
    }
  }

  @override
  Future<bool?> SendVerificationEmail() async {
    try {
      final result = await user.SendVerificationEmail();
      return result;
    } on Exp catch (e) {
      Fail(exp: e);
    }
  }

  @override
  Future<bool> isverified() async {
    try {
      final result = await user.isverified();

      return result;
    } on Exp catch (e) {
      Fail(exp: e);
    }
    return false;
  }

  @override
  Future<Either<Fail, bool>> islogedin() async {
    try {
      final result = await user.islogedIn();
      if (result == true) {
        return right(result);
      } else {
        return right(false);
      }
    } on Exp catch (e) {
      return left(Fail(exp: e.massage));
    }
  }

  void dispose() => _controller.close();
}
