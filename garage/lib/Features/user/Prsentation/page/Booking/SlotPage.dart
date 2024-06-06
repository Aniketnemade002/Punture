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

class SlotPage extends StatelessWidget {
  final List<FeatchSlotImpl> Slots;
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

  const SlotPage(
      {super.key,
      required this.Slots,
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
        title: Text("Time Slots",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: fontstyles.Head,
              fontSize: 40,
              color: Kcolor.bg,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Kcolor.primary,
      ),
      backgroundColor: Kcolor.bg_2,
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is FeatchedSlotListLoading) {
            LoadingPage();
          }

          ///
          ///
          ///
          ///
          ///
          ///
          ///
          ///
        },
        builder: (context, state) {
          return state is NoDataSlot
              ? Center(
                  child: Text("No Slots are Avalible,Sorry!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: fontstyles.Head,
                        fontSize: 20,
                        color: Kcolor.TextB,
                        fontWeight: FontWeight.bold,
                      )),
                )
              : _builSlotList(
                  Slots,
                  Name,
                  address,
                  ownername,
                  GarageLocation,
                  CurrentLocation,
                  villagename,
                  phone_number,
                  Remaning_slot,
                  Cost,
                  garageUid);
        },
      ),
    );
  }
}

Widget _builSlotList(
  final List<FeatchSlotImpl> Slots,
  final String Name,
  final String address,
  final String ownername,
  final GeoPoint GarageLocation,
  final GeoPoint CurrentLocation,
  final String villagename,
  final int phone_number,
  final int Remaning_slot,
  final int Cost,
  final String garageUid,
) {
  return ListView.builder(
    itemCount: Slots.length,
    itemBuilder: (context, index) {
      final Slot = Slots[index];
      return SlotContainer(
          SlotId: Slot.SlotID,
          SlotTime: Slot.SlotTime,
          Name: Name,
          address: address,
          ownername: ownername,
          GarageLocation: GarageLocation,
          CurrentLocation: CurrentLocation,
          villagename: villagename,
          phone_number: phone_number,
          Remaning_slot: Remaning_slot,
          Cost: Cost,
          garageUid: garageUid);
    },
  );
}
