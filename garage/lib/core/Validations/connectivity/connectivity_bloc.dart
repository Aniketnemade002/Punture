import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
part 'connectivity_event.dart';

enum ConnectivityStatus { checking, connected, disconnected }

class ConnectivityState {
  final ConnectivityStatus status;

  ConnectivityState(this.status);
}

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityState(ConnectivityStatus.checking)) {
    on<ConnectivityChanged>(_onConnectivityChanged);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) => add(ConnectivityChanged(result)),
    );
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }

  void _onConnectivityChanged(
      ConnectivityChanged event, Emitter<ConnectivityState> emit) {
    if (event.connectivityResult == ConnectivityResult.none) {
      print("--------------------------LOST--------------");
      emit(ConnectivityState(ConnectivityStatus.disconnected));
    } else {
      emit(ConnectivityState(ConnectivityStatus.connected));
    }
  }
}
