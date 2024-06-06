import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
import 'package:garage/Features/user/Prsentation/bloc/UserBooing_bloc/user_booking_bloc_bloc.dart';
import 'package:garage/Features/user/Prsentation/bloc/UserDash_bloc/bloc/user_dash_bloc.dart';
import 'package:garage/Features/user/Prsentation/page/Booking/getSlot.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/Pages.dart';
import 'package:garage/constant/Common/GeoDistance.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';

class UserBookingListView extends StatelessWidget {
  final List<UserBookingDataModal> bookingItems;
  final TabController tabController;
  final ScrollController scrollController2;

  UserBookingListView({
    required this.tabController,
    required this.bookingItems,
    required this.scrollController2,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBookingBlocBloc, UserBookingBlocState>(
      listener: (context, state) {},
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
                  state is User_NoData_BookingList
                      ? Center(
                          child: Text('Sorry! You Have No Bookings ,Yet !',
                              style: TextStyle(
                                fontFamily: fontstyles.Head,
                                fontSize: 20,
                                color: Kcolor.TextB,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      : _buildBookingList(bookingItems, scrollController2),
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
    List<UserBookingDataModal> Bookings, ScrollController _scrollController2) {
  return ListView.builder(
    controller: _scrollController2,
    itemCount: Bookings.length,
    itemBuilder: (context, index) {
      final _Booking = Bookings[index];

      return BookingContainer(
        cost: _Booking.serviceCost,
        garge_name: _Booking.garageName,
        garage_owner: _Booking.ownername,
        Vehical_No: _Booking.Vehical_No,
        phoneno: _Booking.OwnerMobileNo,
        bookingtime: _Booking.SlotTime.toDate(),
        location: _Booking.GarageLocation ?? GeoPoint(0, 0),
        Discription: _Booking.Discription,
        garegeUid: _Booking.owneruid,
        UserUid: UserUid,
        Distance: GeoDistance.distanceBetween(
            _Booking.CurrentLocation!.latitude,
            _Booking.CurrentLocation!.longitude,
            _Booking.GarageLocation!.latitude,
            _Booking.GarageLocation!.longitude),
      );
    },
  );
}
