//  void _sendNotification() {
//     _firebaseMessaging.getToken().then((token) {
//       print('Device Token: $token');
//       // Replace 'RECIPIENT_TOKEN' with the recipient's FCM token
//       _firebaseMessaging.sendMessage(
//         to: 'RECIPIENT_TOKEN',
//         data: {
//           'title': 'Notification Title',
//           'body': 'Notification Body',
//         },
//       );
//     });
//   }



// class AppNotifications {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

  

//   /// A notification action which triggers a url launch event
//   final String urlLaunchActionId = 'id_1';

  

//   static Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//       onDidReceiveLocalNotification:
//           (int id, String? title, String? body, String? payload) async {
//         didReceiveLocalNotificationStream.add(
//           ReceivedNotification(
//             id: id,
//             title: title,
//             body: body,
//             payload: payload,
//           ),
//         );
//       },
//       notificationCategories: darwinNotificationCategories,
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   static Future<void> showNotification(String title, String msg) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('your_channel_id', 'your_channel_name',
//             importance: Importance.max,
//             priority: Priority.high,
//             showWhen: false);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//         0, title, msg, platformChannelSpecifics);
//   }
// }
