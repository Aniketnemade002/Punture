import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
import 'package:garage/Features/owner/Prsentation/bloc/OwnerBooking_bloc/owner_booking_bloc_bloc.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Owner_dashbord/bloc/o_dash_bord_bloc.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerPages.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/Pages.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';

class OwnerBookingListView extends StatelessWidget {
  final List<OwnerBookingModal> bookingItems;
  final TabController tabController;
  final ScrollController scrollController2;

  OwnerBookingListView({
    required this.tabController,
    required this.bookingItems,
    required this.scrollController2,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerBookingBlocBloc, OwnerBookingBlocState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            TabBar(
              indicatorColor: Kcolor.secondary,
              labelColor: Kcolor.button,
              controller: tabController,
              tabs: [
                Tab(text: 'Your Bookings'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  state is Owner_NoData_BookingList
                      ? Center(
                          child: Text('Sorry! You Have No Hisory ,Yet !',
                              style: TextStyle(
                                fontFamily: fontstyles.Head,
                                fontSize: 20,
                                color: Kcolor.TextB,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      : _buildBookingList(bookingItems, scrollController2)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildBookingList(
    List<OwnerBookingModal> BookingsList, ScrollController _scrollController2) {
  return ListView.builder(
    controller: _scrollController2,
    itemCount: BookingsList.length,
    itemBuilder: (context, index) {
      final _Booking = BookingsList[index];

      return OwnerBookingContainer(
        garge_name: _Booking.garageName,
        garage_owner: _Booking.ownername,
        Vehical_No: _Booking.Vehical_No,
        phoneno: _Booking.userMobileNo,
        bookingtime: _Booking.SlotTime.toDate(),
        Discription: _Booking.Discription,
        H: _Booking,
      );
    },
  );
}
