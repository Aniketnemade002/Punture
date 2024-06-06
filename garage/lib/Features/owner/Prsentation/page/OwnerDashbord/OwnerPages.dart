import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
import 'package:garage/Features/owner/Prsentation/bloc/OwnerBooking_bloc/owner_booking_bloc_bloc.dart';
import 'package:garage/Features/owner/Prsentation/bloc/OwnerHistory_bloc/owner_history_bloc_bloc.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Owner_dashbord/bloc/o_dash_bord_bloc.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerDashBord.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/Pages.dart';
import 'package:garage/constant/Common/common.dart';
import 'package:garage/constant/OnBording/onbording.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class OwnerBookingContainer extends StatelessWidget {
  final String garge_name;
  final String garage_owner;
  final String Vehical_No;
  final int phoneno;
  final DateTime bookingtime;
  final String Discription;
  final OwnerBookingModal H;

  OwnerBookingContainer({
    required this.garge_name,
    required this.garage_owner,
    required this.Vehical_No,
    required this.phoneno,
    required this.bookingtime,
    required this.Discription,
    required this.H,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Kcolor.desable,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.circular(13),
        color: Kcolor.primary,
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
                    height: 240,
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
                        DeleteButton(inputKey: H.owneruid.toString(), H: H)
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
                      SizedBox(
                        width: 212,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            ' $Vehical_No',
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
                      Icon(Icons.person),
                      SizedBox(
                        width: 242,
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
                      CallButton(inputKey: phoneno.toString(), phno: phoneno),
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
                  text: ' Booked ', // Text next to the icon
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

class OwnerHistoryContainer extends StatelessWidget {
  final String User_name;
  final String Vehical_No;
  final int phoneno;
  final DateTime bookingtime;
  final String Discription;

  OwnerHistoryContainer({
    required this.User_name,
    required this.Vehical_No,
    required this.phoneno,
    required this.bookingtime,
    required this.Discription,
  });
  @override
  Widget build(BuildContext context) {
    return BlocListener<ODashBordBloc, ODashBordState>(
      listener: (context, state) {
        if (state is Delete_service_Faild) {
          SlotSystemFailureDialog();
        }
        if (state is Delete_service_Loading) {
          LoadingPage();
        }
        if (state is Delete_service_sucsess) {
          Slot_Delete_Sucess_Dialog();
        }
      },
      child: Container(
        height: 160,
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
                        Text(
                          ' $Vehical_No',
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
                        SizedBox(
                          width: 225,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'Name: $User_name',
                              style: TextStyle(
                                fontFamily: fontstyles.Normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
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
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final String inputKey;

  final OwnerBookingModal H;

  DeleteButton({required this.inputKey, required this.H})
      : super(key: ObjectKey(inputKey));

  @override
  Widget build(BuildContext context) {
    return BlocListener<ODashBordBloc, ODashBordState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: ElevatedButton(
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
                'Service Completed?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Kcolor.TextB,
                ),
              ),
              content: Row(
                children: [
                  Icon(
                    Icons.done,
                    size: 18,
                    color: Kcolor.button,
                  ),
                  Text(
                    ' Are You Sure to Release Slot? ',
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
                  onPressed: () {
                    context.read<ODashBordBloc>().add(GetDelete_service(
                          BookingId: H.BookingId,
                          owneruid: H.owneruid,
                          garageName: H.garageName,
                          ownername: H.ownername,
                          OwnerMobileNo: H.OwnerMobileNo,
                          serviceCost: H.serviceCost,
                          GarageLocation: H.GarageLocation ?? GeoPoint(0, 0),
                          Address: H.Address,
                          SlotTime: H.SlotTime,
                          SlotID: H.BookingId,
                          username: H.username,
                          useruid: H.useruid,
                          Discription: H.Discription,
                          Vehical_No: H.Vehical_No,
                          userMobileNo: H.userMobileNo,
                          CurrentLocation: H.CurrentLocation ?? GeoPoint(0, 0),
                        ));

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => OwnerDashBord(),
                      ),
                      (Route route) => false,
                    );
                    context.read<ODashBordBloc>().add(GetOwner());

                    context
                        .read<OwnerBookingBlocBloc>()
                        .add(GetOwnerBookingList());
                    context
                        .read<OwnerHistoryBlocBloc>()
                        .add(GetOwnerHistoryList());
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          );

          //
        },
        child: Icon(
          Icons.delete,
          color: Kcolor.bg,
        ),
      ),
    );
  }
}

class SlotSystemFailureDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      backgroundColor: Kcolor.bg,
      surfaceTintColor: Kcolor.bg,
      title: Row(
        children: [
          Icon(
            Icons.info,
            size: 25,
            color: Kcolor.button,
          ), // Icon
          Text('SlotSystem Failed'),
        ],
      ),
      content: Text('Please Try Again !'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Kcolor.Fbutton,
            shadowColor: Kcolor.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: Text(
            'Ok',
            style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
          ),
        )
      ],
    );
  }
}

class Slot_Add_Sucess_Dialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      backgroundColor: Kcolor.bg,
      surfaceTintColor: Kcolor.bg,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/images/Animation/CarBooking.json',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Text('Slot Added !'),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Kcolor.Fbutton,
            shadowColor: Kcolor.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: Text(
            'Ok',
            style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
          ),
        )
      ],
    );
  }
}

class Slot_Delete_Sucess_Dialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      backgroundColor: Kcolor.bg,
      surfaceTintColor: Kcolor.bg,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/images/Animation/CarBooking.json',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Text('Service Completed !'),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Kcolor.Fbutton,
            shadowColor: Kcolor.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: Text(
            'Ok',
            style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
          ),
        )
      ],
    );
  }
}

class InvvalidSelectionDialog extends StatelessWidget {
  final DateTime ChooseTime;

  const InvvalidSelectionDialog({super.key, required this.ChooseTime});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      backgroundColor: Kcolor.bg,
      surfaceTintColor: Kcolor.bg,
      title: Row(
        children: [
          Icon(
            Icons.info,
            size: 25,
            color: Kcolor.button,
          ), // Icon
          Text('SlotSystem Failed'),
        ],
      ),
      content: Text(
          'Please select a time between 8 AM and 9 PM OR Your Last Slot Was ${DateFormat('h:mm a').format(ChooseTime)}. So Select after  ${DateFormat('h:mm a').format(ChooseTime)}'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Kcolor.Fbutton,
            shadowColor: Kcolor.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: Text(
            'Ok',
            style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
          ),
        )
      ],
    );
  }
}
