// get list of garages  {

//   Feature <List<GarageMoadal> _getGarage ( String Village ){
//   final Garages = awaitn query that return the list of garages

//    now it is list of json now we want object of json so we need to return list of Garage modal

//    return Garages.map((garage)=> Garagemodal.fromjson(Garage)).toList

//    }
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:garage/Fresh.dart';
import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/auth/Data/RepoImp/UserRepoImpl.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Validations/connectivity/connectivity_bloc.dart';

class app extends StatefulWidget {
  const app({
    super.key,
    required this.WhoUid,
    required this.userWho,
    this.UserFcmToken,
    this.UserisProfileCompleted,
  });

  final String? WhoUid;
  final String? userWho;
  final String? UserFcmToken;
  final String? UserisProfileCompleted;

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> with WidgetsBindingObserver {
  late final AuthRepoImpl _authenticationRepository;
  late final UserRepoImpl _userRepository;

  @override
  void initState() {
    _authenticationRepository = AuthRepoImpl();
    _userRepository = UserRepoImpl();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authenticationRepository.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        print('detachedCallBack()');
        // disconnectXMPP();
        break;
      case AppLifecycleState.resumed:
        print('resumed detachedCallBack()');
        // connect();
        break;
      case AppLifecycleState.hidden:
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
          providers: [BlocProvider(create: (_) => ConnectivityBloc())],
          child: appstart(
            userUid: widget.WhoUid,
            userWho: widget.userWho,
            UserFcmToken: widget.UserFcmToken,
            UserisProfileCompleted: widget.UserisProfileCompleted,
          )),
    );
  }
}

class appstart extends StatefulWidget {
  const appstart({
    super.key,
    required this.userUid,
    required this.userWho,
    this.UserFcmToken,
    this.UserisProfileCompleted,
  });

  final String? userUid;
  final String? userWho;
  final String? UserFcmToken;
  final String? UserisProfileCompleted;

  @override
  State<appstart> createState() => _appstartState();
}

class _appstartState extends State<appstart> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    print("Building user app again");
    FlutterNativeSplash.remove();

    return DismissKeyboard(
        child: MultiBlocListener(
      listeners: [
        BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            void showSnackbar(String message, bool off, int duration) {
              scaffoldMessengerKey.currentState
                  ?.hideCurrentSnackBar(); // Hide previous Snackbars
              scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                actionOverflowThreshold: 0.25,
                padding: const EdgeInsets.all(0.5),
                backgroundColor: off ? Kcolor.Connected : Kcolor.Disconnected,
                content: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
                duration: off == true
                    ? Duration(seconds: duration)
                    : Duration(days: duration),
              ));
            }

            if (state.status == ConnectivityStatus.checking) {
              isinterneconnected = null;
              showSnackbar('No internet connection', false, 1);
            }
            if (state.status == ConnectivityStatus.connected) {
              isinterneconnected = true;
              showSnackbar('Connected! ', true, 2);
            }
            if (state.status == ConnectivityStatus.disconnected) {
              isinterneconnected = false;
              showSnackbar('No internet connection', false, 1);
            }
          },
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Punture',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Kcolor.bg),
          useMaterial3: true,
        ),
        navigatorKey: _navigatorKey,
        home: SelectScreen(),

        // ConnectionPass(
        //     child: finalApp(
        //   userUid: widget.userUid,
        //   userWho: widget.userWho,
        //   UserFcmToken: widget.UserFcmToken,
        //   UserisProfileCompleted: widget.UserisProfileCompleted,
        // )),
      ),
    ));
  }
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}








// class finalApp extends StatefulWidget {
//   const finalApp({
//     super.key,
//     required this.userUid,
//     required this.userWho,
//     this.UserFcmToken,
//     this.UserisProfileCompleted,
//   });

//   final String? userUid;
//   final String? userWho;
//   final String? UserFcmToken;
//   final String? UserisProfileCompleted;

//   @override
//   State<finalApp> createState() => _finalAppState();
// }

// class _finalAppState extends State<finalApp> {
//   @override
//   Widget build(BuildContext context) {
//     return SelectScreen();
//   }
// }
