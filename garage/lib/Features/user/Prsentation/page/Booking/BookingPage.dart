import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:garage/Features/user/Prsentation/bloc/Booking_bloc/Constant_BOOKING.dart';

import 'package:garage/Features/user/Prsentation/bloc/Booking_bloc/bloc/booking_bloc.dart';
import 'package:garage/Features/user/Prsentation/bloc/UserDash_bloc/bloc/user_dash_bloc.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/UserDashbord.dart';
import 'package:garage/Payment/Presentation/pages/UserWallet.dart';
import 'package:garage/constant/Common/common.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/constant/validationError.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:lottie/lottie.dart';

class UserBookingPage extends StatelessWidget {
  final String owneruid;
  final String garageName;
  final String ownername;
  final int OwnerMobileNo;
  final int serviceCost;
  final GeoPoint GarageLocation;
  final String address;

  final String SlotID;
  final Timestamp SlotTime;

  final GeoPoint CurrentLocation;

  const UserBookingPage(
      {super.key,
      required this.owneruid,
      required this.garageName,
      required this.ownername,
      required this.OwnerMobileNo,
      required this.serviceCost,
      required this.GarageLocation,
      required this.address,
      required this.SlotID,
      required this.SlotTime,
      required this.CurrentLocation});
  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (blencelow) {
          showDialog(
            context: context, // Add the context parameter here
            builder: (context) => LowBalenceDialog(),
          );
        }
        if (BookingSuccess) {
          print(' ++++++++YESSS OHHH Fuck ++++++++ ');
          showDialog(
            context: context, // Add the context parameter here
            builder: (context) => SlotBookedDialog(),
          );
        }
        if (BookingFaild) {
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
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Kcolor.primary,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(10, 20), // Rounded bottom edges
            ),
          ),
          leading: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Kcolor.bg),
              )),
          title: Text(" ISSUE ",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: fontstyles.Head,
                fontSize: 35,
                color: Kcolor.bg,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Kcolor.primary,
        ),
        backgroundColor: Kcolor.primary,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.topCenter,
            color: Kcolor.primary,
            child: Container(
              constraints: BoxConstraints(maxHeight: double.infinity),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Kcolor.bg_2,
              ),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.error_outline,
                            size: 30,
                            color: Kcolor.button,
                          ), // Icon on the left side
                        ),
                        TextSpan(
                          text: '  Fill This : ', // Text next to the icon
                          style: TextStyle(
                            color: Kcolor.TextB,
                            fontFamily: fontstyles.Gpop,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shadowColor: Kcolor.secondary,
                    elevation: 5,
                    surfaceTintColor: Kcolor.bg,
                    color: Kcolor.bg,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VheicalNo(),
                          const SizedBox(height: 10),
                          Discription()
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _BookingSubmitButton(
                    owneruid: owneruid,
                    garageName: garageName,
                    ownername: ownername,
                    OwnerMobileNo: OwnerMobileNo,
                    serviceCost: serviceCost,
                    address: address,
                    SlotTime: SlotTime,
                    CurrentLocation: CurrentLocation,
                    SlotID: SlotID,
                    GarageLocation: GarageLocation,
                  ),
                  const SizedBox(height: 328),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VheicalNo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return TextField(
          onChanged: (Vehical_No) => context
              .read<BookingBloc>()
              .add((vehical_No_Change(Vehical_No.trim().toUpperCase()))),
          decoration: InputDecoration(
            labelText: 'Vehical No',
            errorText:
                state.Vehical_No.isNotValid ? "Please Enter Vehical-NO" : null,
            prefixIcon: const Icon(Icons.garage),
            border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class Discription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return TextFormField(
          maxLines: 5, // Allows multiple lines
          onChanged: (Discription) => context
              .read<BookingBloc>()
              .add(DiscriptionChange(Discription.trim())),
          decoration: InputDecoration(
            labelText: 'Discription',
            errorText: state.Discription.isNotValid
                ? "Please Discribe The Issue."
                : null,
            prefixIcon: const Icon(Icons.details),
            border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class _BookingSubmitButton extends StatelessWidget {
  final String owneruid;
  final String garageName;
  final String ownername;
  final int OwnerMobileNo;
  final int serviceCost;
  final GeoPoint GarageLocation;
  final String address;

  final String SlotID;
  final Timestamp SlotTime;

  final GeoPoint CurrentLocation;

  const _BookingSubmitButton(
      {super.key,
      required this.owneruid,
      required this.garageName,
      required this.ownername,
      required this.OwnerMobileNo,
      required this.serviceCost,
      required this.GarageLocation,
      required this.address,
      required this.SlotID,
      required this.SlotTime,
      required this.CurrentLocation});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: state.isValid ? Kcolor.Fbutton : Kcolor.TextB,
            shadowColor: Kcolor.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          onPressed: state.isValid
              ? () => safeOnPressed(context, () {
                    FocusScope.of(context).unfocus();

                    print('CLICKEDD');
                    print('CLICKEDD');
                    print('CLICKEDD');

                    print(
                        'Booking Data Is ${owneruid}      ${garageName},       ${ownername},       ${OwnerMobileNo}        ${serviceCost}        ${GarageLocation}          ${address}         ${SlotID}        ${SlotTime}            ${CurrentLocation}');
                    context.read<BookingBloc>().add(AddBooking(
                        owneruid: owneruid,
                        garageName: garageName,
                        ownername: ownername,
                        OwnerMobileNo: OwnerMobileNo,
                        serviceCost: serviceCost,
                        GarageLocation: GarageLocation,
                        address: address,
                        SlotID: SlotID,
                        SlotTime: SlotTime,
                        CurrentLocation: CurrentLocation));
                  })
              : () => print("notworking"),
          child: state.status.isInProgress
              ? CircularProgressIndicator(
                  color: Kcolor.bg,
                )
              : Text(
                  'Book',
                  style: TextStyle(
                      fontFamily: fontstyles.Gpop,
                      color: state.isValid ? Kcolor.bg : Kcolor.C_Under_3),
                ),
        );
      },
    );
  }
}

class SlotBookedDialog extends StatelessWidget {
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
          const Text('Congratulations!'),
          const SizedBox(height: 5),
          const Text('Slot Booked!'),
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
            context.read<UserDashBloc>().add(GetUser());
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => UserDashBord(),
              ),
              (Route route) => false,
            );
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

class LowBalenceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      backgroundColor: Kcolor.bg,
      surfaceTintColor: Kcolor.bg,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(
              'assets/images/icons/Sad.png',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 20),
          const Text('Please!'),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.error,
                color: Kcolor.secondary,
              ),
              const Text(' Please Recharge!'),
            ],
          ),
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
            context.read<UserDashBloc>().add(GetUser());
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => UserWallet(),
              ),
              (Route route) => false,
            );
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


// class LowBalenceDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       elevation: 20,
//       backgroundColor: Kcolor.bg,
//       surfaceTintColor: Kcolor.bg,
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Lottie.asset(
//             'assets/images/Animation/CarBooking.json',
//             fit: BoxFit.cover,
//           ),
//           const SizedBox(height: 20),
//           const Text('Congratulations!'),
//           const SizedBox(height: 5),
//           const Text('Slot Booked!'),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Kcolor.Fbutton,
//             shadowColor: Kcolor.button,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(7)),
//             ),
//           ),
//           onPressed: () {
//             FocusScope.of(context).unfocus();
//             Navigator.of(context).pop();
//           },
//           child: Text(
//             'Ok',
//             style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
//           ),
//         )
//       ],
//     );
//   }
// }
