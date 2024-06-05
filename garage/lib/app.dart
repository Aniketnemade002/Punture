// get list of garages  {

//   Feature <List<GarageMoadal> _getGarage ( String Village ){
//   final Garages = awaitn query that return the list of garages

//    now it is list of json now we want object of json so we need to return list of Garage modal

//    return Garages.map((garage)=> Garagemodal.fromjson(Garage)).toList

//    }

// String fcm,
//  String village,
//  String Address,
//  int ServiceCost,
//  int wallet,
//  bool isProfileCompleted,
//  String OwnerName,
//  String GarageName,
//  String email,
//  int mobileNo,
// GeoPoint geoLocation,
//  int pin,
//  int SID
//  TimeStampLast SlotTime,
//         int NoOfSlots
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:garage/EmailVerify/VerifyPage.dart';
import 'package:garage/Features/Registration/presentation/OwnerRegisterPages/Pages/OwnerRegisterScreen.dart';
import 'package:garage/Features/Registration/presentation/OwnerRegisterPages/bloc/owner_register_bloc.dart';
import 'package:garage/Features/Registration/presentation/UserRegisterpages/Pages/UserRegisterScreen.dart';
import 'package:garage/Features/Registration/presentation/UserRegisterpages/bloc/user_register_bloc.dart';
import 'package:garage/Features/owner/Data/RepoImp/MainOwnerRepoImpl.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Owner_dashbord/bloc/o_dash_bord_bloc.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Slot_bloc/bloc/slot_bloc.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerDashBord.dart';
import 'package:garage/Features/user/Data/RepoImp/MainUserImpl.dart';
import 'package:garage/Features/user/Prsentation/bloc/Booking_bloc/bloc/booking_bloc.dart';
import 'package:garage/Features/user/Prsentation/bloc/UserDash_bloc/bloc/user_dash_bloc.dart';
import 'package:garage/Features/user/Prsentation/page/Booking/BookingPage.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/UserDashbord.dart';

import 'package:garage/Fresh.dart';
import 'package:garage/Payment/Presentation/bloc/payment_bloc.dart';
import 'package:garage/Payment/Presentation/pages/OwnerWallet.dart';
import 'package:garage/Spalsh.dart';

import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/auth/Data/RepoImp/UserRepoImpl.dart';
import 'package:garage/auth/Login/Prsentation/bloc/login_bloc.dart';
import 'package:garage/auth/bloc/auth_bloc.dart';
import 'package:garage/auth/singup/Presentaion/bloc/singup_bloc.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:garage/core/Validations/connectivity/connectivity_bloc.dart';

import 'package:slide_to_act/slide_to_act.dart';

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
    super.dispose();
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
          providers: [
            BlocProvider(create: (_) => ConnectivityBloc()),
            BlocProvider(create: (_) => SignupBloc()),
            BlocProvider(create: (_) => LoginBloc()),
            BlocProvider(
                create: (_) => AuthBloc(
                    authenticationRepository: _authenticationRepository)),
            BlocProvider(create: (_) => OwnerRegisterBloc()),
            BlocProvider(create: (_) => SlotBloc()..add(LastSlotRequested())),
            BlocProvider(create: (_) => UserRegisterBloc()),
            BlocProvider(
                create: (_) => PaymentBloc()
                  ..add(isuser ? UserFetchBalance() : OwnerFetchBalance())),
            BlocProvider(create: (_) => UserDashBloc()
                // ..add(GetUser())
                // ..add(GetUserBookingList())
                // ..add(GetUserHistoryList()),
                ),
            BlocProvider(create: (_) => BookingBloc()),
            BlocProvider(create: (_) => ODashBordBloc()
                // ..add(GetOwner())
                // ..add(GetOwnerBookingList())
                // ..add(GetOwnerHistoryList()),
                ),
          ],
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
  final _navigatorKey = MainKey;

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
          builder: (context, child) {
            print("Building user app again+");
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                print("Building user app again++");
                UserRepoImpl _UserRepo = UserRepoImpl();
                AuthRepoImpl _auth = AuthRepoImpl();
                MainOwnerRepoImpl _mainOwnerRepo = MainOwnerRepoImpl();
                MainUserRepoImpl _mainUserRepo = MainUserRepoImpl();
                FlutterNativeSplash.remove();

                if (state.status == AuthenticationStatus.unauthenticated) {
                  _navigator.push(MaterialPageRoute(
                      builder: (BuildContext context) => UserDashBord()));
                }

                if (state.status == AuthenticationStatus.unknown) {
                  print("App Enter Unknown");
                  final isloggin = await _auth.islogedin();
                  final isverified = await _auth.isverified();

                  var isLogiinResult;
                  isloggin.fold((l) {
                    Failure.handle(l.exp);
                    isLogiinResult == false;
                  }, (r) {
                    if (r == true) {
                      isLogiinResult = true;
                    } else {
                      isLogiinResult = false;
                    }
                  });

                  if (isLogiinResult == true) {
                    if (isverified) {
                      if (isuser) {
                        if (widget.UserFcmToken != null &&
                            widget.UserFcmToken != '') {
                          await _UserRepo.UserSaveFcmTocken(
                              token: widget.UserFcmToken ?? '');
                          print("App callling _mainUserRepo...... ");

                          final mainUserResult = await _mainUserRepo.GetUser();

                          print("App call _mainUserRepo ...Data Got !! ");
                          mainUserResult.fold(
                            (l) {
                              Failure.handle(l.exp);

                              _navigator.push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const SelectScreen()));
                            },
                            (r) {
                              final _isProfileCompleted = r!.isProfileCompleted;

                              if (_isProfileCompleted) {
                                print(
                                    "=================== In App  User ======");
                                _navigator.push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserDashBord(),
                                  ),
                                );
                              } else {
                                _navigator.push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserRegisterScreen(),
                                  ),
                                );
                              }
                            },
                          );
                        }
                      } else {
                        if (widget.UserFcmToken != null &&
                            widget.UserFcmToken != '') {
                          await _UserRepo.OwnrSaveFcmTocken(
                              token: widget.UserFcmToken ?? '');
                        }

                        print("App callingg OwnerUserRepo .... !! ");

                        final mainOwnerResult = await _mainOwnerRepo.GetOwner();
                        print("App call OwnerUserRepo ...Data Got !! ");

                        mainOwnerResult.fold(
                          (l) {
                            Failure.handle(l.exp);

                            print("App call OwnerUserRepo  Fail ");
                            _navigator.push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SelectScreen()));
                          },
                          (r) {
                            if (r!.isProfileCompleted) {
                              _navigator.push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OwnerDashBord(),
                                ),
                              );
                            } else {
                              print("App call Owne Registration Screen  Got");

                              _navigator.push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OwnerRegisterScreen(),
                                ),
                              );
                            }
                          },
                        );
                      }
                    } else {
                      _navigator.push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              EmailVerificationScreen()));
                    }
                  } else {
                    print('Golure Golure');
                    _navigator.push(MaterialPageRoute(
                        builder: (BuildContext context) => UserDashBord()));
                  }
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (setings) {
            print("Restart Screen ....! ");

            return MaterialPageRoute(
                builder: (BuildContext context) => const AppSplash());
          }),
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

class NotifyServiceDone {
  static void showDialogBox(String title, String message) {
    if (MainKey.currentState != null) {
      showDialog(
        context: MainKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print(
          'Scaffold key is not initialized or scaffold is not attached to the widget tree.');
    }
  }
}

class NotifyBooking {
  static void showDialogBox(String title, String message) {
    if (MainKey.currentState != null) {
      showDialog(
        context: MainKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print(
          'Scaffold key is not initialized or scaffold is not attached to the widget tree.');
    }
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
