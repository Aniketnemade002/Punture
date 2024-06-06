import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Features/Registration/presentation/OwnerRegisterPages/bloc/owner_register_bloc.dart';
import 'package:garage/Features/user/Data/ModalImpl/FeatchGarageModal.dart';
import 'package:garage/Features/user/Prsentation/bloc/Booking_bloc/bloc/booking_bloc.dart';
import 'package:garage/Features/user/Prsentation/page/Booking/getSlot.dart';
import 'package:garage/constant/Common/common.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';

class GaragePage extends StatelessWidget {
  final List<FeatchGarageMoadlImpl> Garages;

  const GaragePage({super.key, required this.Garages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Kcolor.primary,
        centerTitle: true,
        leadingWidth: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(10, 20), // Rounded bottom edges
          ),
        ),
        leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Kcolor.bg),
            )),
        title: Text("Garages",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: fontstyles.Head,
              fontSize: 40,
              color: Kcolor.bg,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Kcolor.primary,
      ),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is FeatchedGaragesLoading) {
            LoadingPage();
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Center(
            child: state is NoDataGarage
                ? Center(
                    child: Text(
                      "No Garages are Available, Sorry!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: fontstyles.Head,
                        fontSize: 20,
                        color: Kcolor.TextB,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : _builGarageList(Garages),
          );
        },
      ),
    );
  }
}

Widget _builGarageList(List<FeatchGarageMoadlImpl> Garages) {
  return ListView.builder(
    itemCount: Garages.length,
    itemBuilder: (context, index) {
      final Garage = Garages[index];
      return GetGarageContainer(
        Name: Garage.ownerName,
        address: Garage.address,
        ownername: Garage.ownerName,
        GarageLocation: Garage.geoLocation ?? GeoPoint(0, 0),
        CurrentLocation: Garage.currentGeopoint ?? GeoPoint(0, 0),
        villagename: Garage.village,
        phone_number: Garage.mobileNo,
        Remaning_slot: Garage.noOfSlots,
        Cost: Garage.serviceCost,
        garageUid: Garage.UID,
      );
    },
  );
}
