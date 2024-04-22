import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:garage/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Fail {
  final dynamic exp;
  final bool? result;
  Fail({required this.exp, this.result = false});
}

class Exp implements Exception {
  final dynamic massage;
  Exp([this.massage = 'An Unexpected Error occurred !']);
}

class Failure {
  final dynamic e;

  Failure({required this.e});

  static String _getErrorMessage(Exception exception) {
    if (exception is FirebaseAuthException) {
      return _getAuthErrorMessage(exception);
    } else if (exception is FirebaseException) {
      return _getFirestoreErrorMessage(exception);
    } else {
      return exception.toString();
    }
  }

  static void handle(dynamic e) {
    String errorMessage = _getErrorMessage(e);
    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        actionOverflowThreshold: 0.25,
        padding: const EdgeInsets.all(1),
        backgroundColor: Colors.red,
        content: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static String _getAuthErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'user-not-found':
        return 'User not found.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'The email is already in use by another account.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      default:
        return 'An unexpected authentication error occurred.';
    }
  }

  static String _getFirestoreErrorMessage(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return 'Permission denied.';
      case 'not-found':
        return 'Document or resource not found.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'unavailable':
        return 'The service is currently unavailable.';
      default:
        return 'An unexpected Firestore error occurred.';
    }
  }
}


//user Failure in snack bar;