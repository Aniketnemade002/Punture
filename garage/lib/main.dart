import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garage/Fresh.dart';
import 'package:garage/app.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/constant.dart ' as c;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:bloc/bloc.dart';

final _storage = storage;
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //-------------------------------------------------------------------------------
  //permission

  await Permission.locationWhenInUse.request();
  await Permission.notification.request();

// -----------------------------------------------------------------------------------
//initialisation

  if (await Permission.notification.isGranted) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.requestPermission(provisional: true);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    token = await FirebaseMessaging.instance.getToken() ?? '';
    print("----------------------------Fcm Tocken $token ");
    pref = await SharedPreferences.getInstance();

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // await AppNotifications.init();
  }

  //-----------------------------------------------------------------------------
  // Checking  firstrun // UserEntity // Uid // isProfileCompleted

  final keysToEliminate = ["Uid", "S_UserEntity", "isProfileCompleted"];

  if (pref?.getBool('FirstRun') ?? true) {
    print("Inside first time delete");
    await Future.wait(keysToEliminate.map((key) => _storage.delete(key: key)));
  }

  UserUid = await _storage.read(key: 'Uid') ?? '';
  final String? Uid = UserUid;
  isProfileCompleted = await _storage.read(key: 'isProfileCompleted') ?? '';
  final who = await _storage.read(key: 'S_UserEntity');

  if (who == 'USER') {
    isuser = true;
  } else if (who == 'OWNER') {
    isuser = false;
  } else {
    isuser = null;
  }

  print("Calling main app");

  runApp(RestartWidget(
      child: app(
    WhoUid: Uid,
    userWho: who,
    UserFcmToken: token,
    UserisProfileCompleted: isProfileCompleted,
  )));
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});
  final Widget child;
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
  void restartApp() async {
    setState(() {
      key = UniqueKey();
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget.child),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
