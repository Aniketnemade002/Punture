import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/constant/Common/common.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:text_scroll/text_scroll.dart';

class BookingContainer extends StatelessWidget {
  final String garge_name;
  final String garage_owner;
  final String Vehical_No;
  final int phoneno;
  final DateTime bookingtime;
  final GeoPoint location;
  final String Discription;
  final int cost;
  final double Distance;
  final garegeUid;
  final UserUid;

  BookingContainer(
      {required this.garge_name,
      required this.garage_owner,
      required this.Vehical_No,
      required this.phoneno,
      required this.bookingtime,
      required this.location,
      required this.Discription,
      this.garegeUid,
      this.UserUid,
      required this.cost,
      required this.Distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Kcolor.desable,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.circular(13),
        color: Kcolor.C_Under_3,
      ),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 18),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  surfaceTintColor: Kcolor.bg,
                  backgroundColor: Kcolor.bg,
                  content: SizedBox(
                    height: 250,
                    width: 300,
                    child: Column(
                      children: [
                        SizedBox(
                          child: Text(
                            " Discription ",
                            style: TextStyle(
                              fontFamily: fontstyles.Gpop,
                              fontSize: 25,
                              color: Kcolor.TextB,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 150,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              " $Discription ",
                              style: TextStyle(
                                fontFamily: fontstyles.Gpop,
                                fontSize: 15,
                                color: Kcolor.TextB,
                              ),
                            ),
                          ),
                        ),
                        CallButton(inputKey: phoneno.toString(), phno: phoneno)
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 00, 10, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 224, 224, 224),
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 235,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: TextScroll(
                            ' $garge_name    ',
                            mode: TextScrollMode.bouncing,
                            velocity: Velocity(pixelsPerSecond: Offset(150, 0)),
                            delayBefore: Duration(milliseconds: 500),
                            numberOfReps: 5,
                            pauseBetween: Duration(milliseconds: 50),
                            style: TextStyle(
                              fontFamily: fontstyles.Gpop,
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                              color: Kcolor.TextB,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.calendar_month),
                            Text(
                              ' ${DateFormat('dd/MM/yyyy').format(bookingtime)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Kcolor.TextB,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.engineering),
                      SizedBox(
                        width: 252,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            ' $garage_owner',
                            style: TextStyle(
                              fontFamily: fontstyles.Normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Kcolor.TextB,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      LocationButton(
                        inputKey: garegeUid,
                        long: location.longitude,
                        lat: location.latitude,
                        Location: garge_name,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.motorcycle),
                      Text(
                        ' $Vehical_No',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Kcolor.TextB,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 20,
                            ),
                            Text(' $phoneno')
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_outlined,
                              size: 20,
                            ),
                            Text(
                              ' $cost',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Kcolor.TextB,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.access_time),
                            Text(
                              ' ${DateFormat('h:mm a').format(bookingtime)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Kcolor.TextB,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Paid',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Kcolor.Connected,
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Lottie.asset(
                        'assets/images/Animation/user/LOC.json',
                      ),
                    )),
                TextSpan(
                  text: ' Only', // Text next to the icon
                  style: TextStyle(
                    color: Kcolor.TextB,
                    fontFamily: fontstyles.Gpop,
                    fontWeight: FontWeight.w200,
                    fontSize: 10,
                  ),
                ),
                TextSpan(
                  text:
                      ' ${Distance.toStringAsFixed(2)}', // Text next to the icon
                  style: TextStyle(
                    color: Kcolor.secondary,
                    fontFamily: fontstyles.Gpop,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text: ' Km Away !  ', // Text next to the icon
                  style: TextStyle(
                    color: Kcolor.TextB,
                    fontFamily: fontstyles.Gpop,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserHistoryContainer extends StatelessWidget {
  final String garge_name;
  final String garage_owner;
  final String Vehical_No;
  final int phoneno;
  final DateTime bookingtime;

  final String Discription;
  final int cost;

  UserHistoryContainer({
    required this.garge_name,
    required this.garage_owner,
    required this.Vehical_No,
    required this.phoneno,
    required this.bookingtime,
    required this.Discription,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 183,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Kcolor.desable,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.circular(13),
        color: Kcolor.Connected,
      ),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  surfaceTintColor: Kcolor.bg,
                  backgroundColor: Kcolor.bg,
                  content: SizedBox(
                    height: 250,
                    width: 300,
                    child: Column(
                      children: [
                        SizedBox(
                          child: Text(
                            " Discription ",
                            style: TextStyle(
                              fontFamily: fontstyles.Gpop,
                              fontSize: 25,
                              color: Kcolor.TextB,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 150,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              " $Discription ",
                              style: TextStyle(
                                fontFamily: fontstyles.Gpop,
                                fontSize: 15,
                                color: Kcolor.TextB,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Kcolor.Fbutton,
                              shadowColor: Kcolor.button,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              )),
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontFamily: fontstyles.Gpop,
                              fontSize: 15,
                              color: Kcolor.bg,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 00, 10, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 224, 224, 224),
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        ' $garge_name',
                        style: TextStyle(
                          fontFamily: fontstyles.Gpop,
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          color: Kcolor.TextB,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.engineering),
                      SizedBox(
                        width: 212,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            ' $garage_owner',
                            style: TextStyle(
                              fontFamily: fontstyles.Normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Kcolor.TextB,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.calendar_month),
                            Text(
                              ' ${DateFormat('dd/MM/yyyy').format(bookingtime)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Kcolor.TextB,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.motorcycle),
                      Text(
                        ' $Vehical_No',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Kcolor.TextB,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 20,
                            ),
                            Text(' $phoneno')
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_outlined,
                              size: 20,
                            ),
                            Text(
                              ' $cost',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Kcolor.TextB,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.access_time),
                            Text(
                              ' ${DateFormat('h:mm a').format(bookingtime)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Kcolor.TextB,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Paid',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Kcolor.Connected,
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ))),
                TextSpan(
                  text: ' Completed ', // Text next to the icon
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontstyles.Gpop,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// LocationButton();

class CallButton extends StatelessWidget {
  final String inputKey;
  final int phno;

  CallButton({required this.inputKey, required this.phno})
      : super(key: ObjectKey(inputKey));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Kcolor.Fbutton,
        shadowColor: Kcolor.button,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            surfaceTintColor: Kcolor.bg,
            title: Text(
              'Call?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Kcolor.TextB,
              ),
            ),
            content: Row(
              children: [
                Icon(
                  Icons.info,
                  size: 18,
                  color: Kcolor.button,
                ),
                Text(
                  'Make a call with Mechanic.',
                  style: TextStyle(fontFamily: fontstyles.Gpop),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => DirectCaller().makePhoneCall(phno.toString()),
                child: const Text('Yes'),
              ),
            ],
          ),
        );

        //
      },
      child: Icon(
        Icons.phone,
        color: Kcolor.bg,
      ),
    );
  }
}
