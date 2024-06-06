import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Features/user/Domain/Entity/UserModal.dart';
import 'package:garage/Features/user/Prsentation/bloc/Booking_bloc/bloc/booking_bloc.dart';
import 'package:garage/Features/user/Prsentation/page/Booking/BookingPage.dart';
import 'package:garage/Features/user/Prsentation/page/Booking/SlotPage.dart';

import 'package:garage/Features/user/Prsentation/page/UserDash/Pages.dart';
import 'package:garage/Test.dart';
import 'package:garage/constant/Common/GeoDistance.dart';
import 'package:garage/constant/Common/common.dart';
import 'package:garage/constant/constant.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';

class GetGarageContainer extends StatelessWidget {
  final String Name;
  final String address;
  final String ownername;
  final GeoPoint GarageLocation;
  final GeoPoint CurrentLocation;
  final String villagename;
  final int phone_number;
  final int Remaning_slot;
  final int Cost;
  final String garageUid;

  const GetGarageContainer({
    super.key,
    required this.Name,
    required this.address,
    required this.ownername,
    required this.GarageLocation,
    required this.CurrentLocation,
    required this.villagename,
    required this.phone_number,
    required this.Remaning_slot,
    required this.Cost,
    required this.garageUid,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is FeatchedSlotList) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SlotPage(
                  Slots: state.SlotList,
                  Name: Name,
                  address: address,
                  ownername: ownername,
                  GarageLocation: GarageLocation,
                  CurrentLocation: CurrentLocation,
                  villagename: villagename,
                  phone_number: phone_number,
                  Remaning_slot: Remaning_slot,
                  Cost: Cost,
                  garageUid: garageUid),
            ),
          );
        }
        if (state is FeatchedSlotListLoading) {
          LoadingPage();
        }
        if (state is FeatchedSlotListFaild) {
          ScaffoldMessenger.of(context)
              .hideCurrentSnackBar(); // Hide previous Snackbars
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              actionOverflowThreshold: 0.25,
              padding: const EdgeInsets.all(0.5),
              backgroundColor: const Color.fromARGB(255, 255, 17, 0),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Somthing Went Wrong ! ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.sms_failed,
                    color: Kcolor.bg,
                  )
                ],
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          height: 179,
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
                  ///
                  ///
                  ///
                  // ///
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SlotPage(
                  //         Slots: TestSlots,
                  //         Name: Name,
                  //         address: address,
                  //         ownername: ownername,
                  //         GarageLocation: GarageLocation,
                  //         CurrentLocation: CurrentLocation,
                  //         villagename: villagename,
                  //         phone_number: phone_number,
                  //         Remaning_slot: Remaning_slot,
                  //         Cost: Cost,
                  //         garageUid: garageUid),
                  //   ),
                  // );

                  ///
                  ///
                  ///
                  ///
                  ///

                  context.read<BookingBloc>().add(GetSlot(OwnerId: garageUid));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(10, 00, 10, 18),
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
                            width: 232,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                ' $Name',
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
                            width: 7,
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                Icon(Icons.last_page),
                                Text(
                                  'Free Slots : ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Kcolor.Connected,
                                  ),
                                ),
                                Text(
                                  '$Remaning_slot',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red,
                                  ),
                                )
                              ],
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
                            width: 242,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                ' $ownername',
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
                            width: 12,
                          ),
                          SizedBox(
                            height: 30,
                            width: 70,
                            child: CallButton(
                              inputKey: phone_number.toString(),
                              phno: phone_number,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 20,
                          ),
                          Text(' $phone_number')
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.map),
                              SizedBox(
                                width: 242,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    '   $address',
                                    style: TextStyle(
                                      fontFamily: fontstyles.Gpop,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Kcolor.TextB,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee_outlined,
                                  size: 20,
                                ),
                                Text(
                                  '$Cost',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Kcolor.Connected,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
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
                          ' ${GeoDistance.distanceBetween(CurrentLocation.latitude, CurrentLocation.longitude, GarageLocation.latitude, GarageLocation.longitude).toStringAsFixed(1)}', // Text next to the icon
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
                        fontWeight: FontWeight.w200,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SlotContainer extends StatelessWidget {
  final String SlotId;
  final Timestamp SlotTime;

  final String Name;
  final String address;
  final String ownername;
  final GeoPoint GarageLocation;
  final GeoPoint CurrentLocation;
  final String villagename;
  final int phone_number;
  final int Remaning_slot;
  final int Cost;
  final String garageUid;

  const SlotContainer(
      {super.key,
      required this.SlotId,
      required this.SlotTime,
      required this.Name,
      required this.address,
      required this.ownername,
      required this.GarageLocation,
      required this.CurrentLocation,
      required this.villagename,
      required this.phone_number,
      required this.Remaning_slot,
      required this.Cost,
      required this.garageUid});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: 75,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Kcolor.desable,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 4.0,
              ),
            ],
            borderRadius: BorderRadius.circular(13),
            color: Kcolor.button,
          ),
          margin: EdgeInsets.fromLTRB(10, 5, 10, 18),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserBookingPage(
                              owneruid: garageUid,
                              garageName: Name,
                              ownername: ownername,
                              OwnerMobileNo: phone_number,
                              serviceCost: Cost,
                              GarageLocation: GarageLocation,
                              address: address,
                              SlotID: SlotId,
                              SlotTime: SlotTime,
                              CurrentLocation: CurrentLocation)));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(10, 00, 10, 4),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ' ${DateFormat('dd/MM/yyyy').format(SlotTime.toDate())}',
                        style: TextStyle(
                          fontFamily: fontstyles.Gpop,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          color: Kcolor.TextB,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      color: Kcolor.bg,
                    ),
                    SizedBox(
                      child: Text(
                        '  ${DateFormat('h:mm a').format(SlotTime.toDate())}',
                        style: TextStyle(
                          fontFamily: fontstyles.Normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Kcolor.bg,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
