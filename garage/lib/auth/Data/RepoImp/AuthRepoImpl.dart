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
  authenticated,
  unauthenticated,
  PendingVerification
}

class AuthRepoImpl implements AuthRepo {
  final UserDataSourceImpl user = UserDataSourceImpl();
  final _storage = storage;

  final _controller = StreamController<AuthenticationStatus>();
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<Either<Fail, LoginResponse?>> Login(
      {required String email, required String password}) async {
    try {
      final loginResponce = await user.LogIn(email: email, password: password);

      if (loginResponce != null) {
        await _storage.write(key: 'Uid', value: loginResponce.Uid);
        UserUid = loginResponce.Uid;
        await _storage.write(
            key: 'LoginInfo', value: json.encode(loginResponce));
        if (loginResponce.isverified) {
          UserUid = loginResponce.Uid;
          if (loginResponce.isProfileCompleted) {
            await _storage.write(key: 'isProfileCompleted', value: 'yes');
          }
          _controller.add(AuthenticationStatus.authenticated);
          return right(loginResponce);
        } else {
          _controller.add(AuthenticationStatus.PendingVerification);
          return right(null);
        }
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
        return right(null);
      }
    } on Exp catch (e) {
      return left(Fail(exp: e));
    }
  }

  @override
  Future<void> Logout() async {
    try {
      user.Logout();
      await _storage.deleteAll();
      _controller.add(AuthenticationStatus.unauthenticated);
    } on Exp catch (e) {
      Fail(exp: e);
    }
  }

  @override
  Future<Either<Fail, bool>> RedSendVerificationEmail() async {
    try {
      final result = await user.ReSendVerificationEmail();
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e));
    }
  }

  @override
  Future<Either<Fail, bool>> SendVerificationEmail() async {
    try {
      final result = await user.SendVerificationEmail();
      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e));
    }
  }

  @override
  Future<Either<Fail, bool>> isverified() async {
    try {
      final result = await user.isverified();

      return right(result);
    } on Exp catch (e) {
      return left(Fail(exp: e));
    }
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
      return left(Fail(exp: e));
    }
  }

  void dispose() => _controller.close();
}
