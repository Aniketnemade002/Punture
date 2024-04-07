import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:garage/constant/constant.dart';

enum ConnectivityStatus { checking, connected, disconnected }

class ConnectivityState {
  final ConnectivityStatus status;

  ConnectivityState(this.status);
}

class ConnectivityBloc extends Bloc<ConnectivityResult, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityState(ConnectivityStatus.checking));

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityResult event) async* {
    if (event == ConnectivityResult.none) {
      yield ConnectivityState(ConnectivityStatus.disconnected);
    } else {
      yield ConnectivityState(ConnectivityStatus.connected);
    }
  }
}

// class ConnectionPass extends StatefulWidget {
//   final Widget child;

//   const ConnectionPass({super.key, required this.child});

//   @override
//   _ConnectionPassState createState() => _ConnectionPassState();
// }

// class _ConnectionPassState extends State<ConnectionPass> {
//   @override
//   void initState() {
//     super.initState();

//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       if (result == ConnectivityResult.none) {
//         isinterneconnected = true;
//         showSnackbar('No internet connection', false, 1);
//         print("=========================== loss ==========================");
//       }
//       if (result == ConnectivityResult.wifi ||
//           result == ConnectivityResult.mobile) {
//         isinterneconnected = false;
//         showSnackbar('Connected! ', true, 2);
//       }
//     });
//   }

//   Future<void> checkConnectivity() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       isinterneconnected = true;
//       showSnackbar('No internet connection', false, 1);
//       print("=========================== loss ==========================");
//     }
//     if (connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.mobile) {
//       isinterneconnected = false;
//       showSnackbar('Connected! ', true, 2);
//     }
//   }

//   void showSnackbar(String message, bool off, int duration) {
//     scaffoldMessengerKey.currentState
//         ?.hideCurrentSnackBar(); // Hide previous Snackbars
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       behavior: SnackBarBehavior.floating,
//       actionOverflowThreshold: 0.25,
//       padding: const EdgeInsets.all(1),
//       backgroundColor: off ? Kcolor.Connected : Kcolor.Disconnected,
//       content: Text(
//         message,
//         textAlign: TextAlign.center,
//         style: const TextStyle(color: Colors.white),
//       ),
//       duration:
//           off == true ? Duration(seconds: duration) : Duration(days: duration),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldMessenger(
//       child: widget.child,
//     );
//   }
// }
