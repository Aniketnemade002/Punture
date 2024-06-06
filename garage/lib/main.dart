import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garage/Fresh.dart';
import 'package:garage/app.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/constant.dart ' as c;
import 'package:garage/notification.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:bloc/bloc.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await setupFlutterNotifications();

  await showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Channel ID = ${message.notification!.android!.channelId.toString()}");
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    showBadge: true,
    playSound: true, enableVibration: true,
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/launcher_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.

  isFlutterLocalNotificationsInitialized = true;
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> showFlutterNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title.toString(),
      notification.body.toString(),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          sound: channel.sound,
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
          priority: Priority.high,
          icon: '@mipmap/launcher_icon',
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Future.delayed(Duration(seconds: 5));
  print("APP Start +");
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  print("APP Start ++++");

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  print("APP Start +++");

  //-------------------------------------------------------------------------------

  await Permission.storage.request();
  await Permission.notification.request();
  await Permission.locationWhenInUse.request();
  await Permission.phone.request();
  print("APP Start ++++");

// -----------------------------------------------------------------------------------
//initialisation

  if (await Permission.notification.isGranted) {
    print("APP Start +++++");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.requestPermission(provisional: true);
    print("APP Start ++++++");

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    print("APP Start +++++++");

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: false,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    FCMtoken = await FirebaseMessaging.instance.getToken() ?? '';
    print("----------------------------Fcm Tocken $FCMtoken ");
    pref = await SharedPreferences.getInstance();
    Startpref = await SharedPreferences.getInstance();
    Run = await SharedPreferences.getInstance();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // await AppNotifications.init();
  }
  print("GetLocation +");
  Location location = Location();
  LocationData _locationData;
  print("GetLocation ++++");
  _locationData = await location.getLocation();

  CurrentLOC =
      GeoPoint(_locationData.latitude ?? 0, _locationData.longitude ?? 0);
  print("GetLocation ++++ ${CurrentLOC!.latitude}${CurrentLOC!.latitude}");

  //-----------------------------------------------------------------------------
  // Checking  firstrun // UserEntity // Uid // isProfileCompleted

  final keysToEliminate = [
    "Uid",
    "S_UserEntity",
  ];

  if (Startpref?.getBool('FirstRun') ?? true) {
    print("Inside first time delete");
    await Future.wait(keysToEliminate.map((key) => pref.remove(key)));
  }

  UserUid = await pref.getString('Uid') ?? '';
  print("User UID $UserUid");
  final String? Uid = UserUid;

  final who = await pref.getString('S_UserEntity');

  if (who == 'USER') {
    isuser = true;
  } else if (who == 'OWNER') {
    isuser = false;
  } else {
    isuser = false;
  }

  print("++++++++Now this is $isuser");
  print("Calling main app");

  runApp(RestartWidget(
      child: app(
    WhoUid: Uid,
    userWho: who,
    UserFcmToken: FCMtoken,
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
  }

  @override
  Widget build(BuildContext context) {
    print("Restarted app again");
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
