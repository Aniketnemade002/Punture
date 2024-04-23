import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class Kcolor {
  static Color primary = hexToColor('#990011');
  static Color bg = hexToColor('#faf9f9');
  static Color bg_2 = hexToColor('#f3f3f6');
  static Color Black = hexToColor('#1d1d1d');
  static Color TextB = hexToColor('#35383b');

  static Color secondary = hexToColor('#bd3d4a'); // use this for wallet
  static Color desable = hexToColor('#c7c5c5');
  static Color button = hexToColor('#cb4950');
  static Color Connected = hexToColor('#23b84b');
  static Color Disconnected = hexToColor('#959a9d');

  static Color C_Under = hexToColor('#ffdbd6');
  static Color C_Under_2 = hexToColor('#e59596');
  static Color C_Under_3 = hexToColor('#fce9ea');
  static Color C_Under_4 = hexToColor('#f8e9eb');

  static Color Fbutton = hexToColor('#c00c26');
  // #da2633 payment button
}

// dR0eX2df8dmrdYhsb1lEoTGVkArjCZ3q
// 13094748889332409102

late bool isuser;
bool isinterneconnected = false;
late SharedPreferences? pref;
late bool? GodMode;
late String UserUid;
late String? FCMtoken;
late bool? firstRun;
late bool? isProfileVerified;
late String? isProfileCompleted;
late GeoPoint? GetgeoPoint;
late String? GetVillage;
late int CurrentBalence;

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

const storage = FlutterSecureStorage(
    iOptions: IOSOptions(accountName: 'Punture'),
    aOptions: AndroidOptions(encryptedSharedPreferences: true));




                          //     Card(
                          //   shadowColor: Kcolor.secondary,
                          //   elevation: 5,
                          //   surfaceTintColor: Kcolor.bg,
                          //   color: Kcolor.bg,
                          //   child: Padding(
                          //       padding: const EdgeInsets.all(10),
                          //       child: Text("HIIi")),
                          // ),

  // SlideAction(
  //               sliderRotate: false,

  //               borderRadius: 8,
  //               innerColor: Kcolor.Fbutton,
  //               outerColor: Kcolor.C_Under_4,

  //               // Let's change the icon and the icon color
  //               sliderButtonIcon: const Icon(
  //                 Icons.arrow_forward_ios_outlined,
  //                 color: Colors.white,
  //               ),
  //               textColor: Kcolor.TextB,
  //               elevation: 20,

  //               text: "Pay",

              
  //             ),

//Storage =
  // _storage.write(    key: 'Uid',                    value: loginResponce.Uid);
  // _storage.write(    key: 'isUserVerified',     value: 'yes');
    // _storage.write(    key: 'isProfileCompleted',     value: 'yes');
  // _storage.write(    key: 'LoginInfo',              value: json.encode(loginResponce));
   //  _storage.write(    key: 'S_UserEntity',value: isuser == true ? 'USER' : 'OWNER');



  //  pref!.setString('UserEntity',isuser == true ? 'user' : 'owner')



// Chache =







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
