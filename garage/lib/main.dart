import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garage/Fresh.dart';
import 'package:garage/app.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/constant.dart ' as c;
import 'package:garage/core/Validations/connectivity.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:bloc/bloc.dart';

const storage = FlutterSecureStorage(
    iOptions: IOSOptions(accountName: 'garage_application'),
    aOptions: AndroidOptions(encryptedSharedPreferences: true));
void main() async {
//   await Permission.locationWhenInUse.request();
//   await Permission.notification.request();
//   await Permission.photos.request();

//   // Obtain shared preferences.

  WidgetsFlutterBinding.ensureInitialized();

//   // on first run geet get fcm instance  (Shared prefrence)

//   //  String? token = await FirebaseMessaging.instance.getToken();
//   //then faterloging

// //   Future<void> saveTokenToDatabase(String token) async {
// //   // Assume user is logged in for this example
// //   String userId = FirebaseAuth.instance.currentUser.uid;

// //   await FirebaseFirestore.instance
// //     .collection('users')
// //     .doc(userId)
// //     .update({
// //       'tokens': FieldValue.arrayUnion([token]),
// //     });
// // }

//   // upload to fire store of specifc UID

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   // FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

  // final pref = await SharedPreferences.getInstance();

  pref = await SharedPreferences.getInstance();

//     final keysToEliminate = ["jwt", "user", "isProfileCompleted"];
//   if (preferences.getBool('first_run') ?? true) {
//     print("Inside first time delete");
//     await Future.wait(keysToEliminate.map((key) => storage.delete(key: key)));
//     preferences.setBool('first_run', false);
//     preferences.setString('language', 'en');
//   }
//   print("Calling main app");

//   String? isProfileCompleted = await storage.read(key: 'isProfileCompleted');
//   String? language = preferences.getString('language');
  isuser = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Kcolor.bg),
          useMaterial3: true,
        ),
        home: SelectScreen());
  }
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
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

//first run ==true
// choose who are u
//OnBording Screen
//login

// while routing create is user or owner path at initial point and rout pages according to

// create slots as per convinience of owner (get last slot number(SID) from db and + 1 it  and add timing )

// edit / Delete funcationality need to add for slot

// note : at the time of user creatin store that uid in firebase  as a uniqueid
// 2. slot id
// 1. search all garages with vilage
// 2.now get unique id of specific owner  add create booking

// as booking request fire remove booking slot from owners avilabel and reduce the count

// 3. add booking in booking collecction  and return the uid of booking

//  ( final refnewbooking = add thebooking  )
//   docId= refnewbooking.id

// and add this docID in both garage uid and user uid aswells as i the history

//https://www.google.com/maps/dir/?api=1&destination={lat},{lon}

// booking flow

// add button

// open popup window  add  location

//  redirect ot page which has list of garages
//  choose on garages has locations and slot total slot availabes

//  open srollable bootom sheet on choose it will open booking comfermation pop up
// add the User  fcm token in booking
//  after comfirmation show rorating animmation afer done showw booking Done animation such as google payment Done

//  at the slot booked section  at owner show the Release button

//   after clicking it

//      remove the booking from booking array in both user and owner with repective id
//      and update write all funcanatlitys in try catch

//take id of respective fcm tocken  and send the massage that Bingoo !! your vehical No{MH**** } is releasd go and take you ride to your Home

// show Your profile name  at top for garage garage name

// Write specific funtionality to retrive respective ids for owner and user

// create the wallet functionality
// user need to add money in  wallet
// and at the booking wallet will update with new price
//and owner will get money
// Slide to act button

// about page must be there dont forgett
