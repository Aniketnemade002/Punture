import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Owner_dashbord/bloc/o_dash_bord_bloc.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerPages.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/Pages.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';

class OwnerHistoryListView extends StatelessWidget {
  final List<OwnerHistoryModal> bookingItems;
  final TabController tabController;
  final ScrollController scrollController;

  OwnerHistoryListView({
    required this.bookingItems,
    required this.scrollController,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ODashBordBloc, ODashBordState>(
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
                  state is Owner_LoadingNo_Data_HistorygList
                      ? Center(
                          child: Text('Sorry! You Have No Hisory ,Yet !',
                              style: TextStyle(
                                fontFamily: fontstyles.Head,
                                fontSize: 20,
                                color: Kcolor.TextB,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      : _buildHistoryListView(bookingItems, scrollController)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildHistoryListView(
    List<OwnerHistoryModal> History, ScrollController _scrollController) {
  return ListView.builder(
    controller: _scrollController,
    itemCount: History.length,
    itemBuilder: (context, index) {
      final H = History[index];
      return OwnerHistoryContainer(
        Vehical_No: H.Vehical_No,
        phoneno: H.userMobileNo,
        bookingtime: H.SlotTime.toDate(),
        Discription: H.Discription,
        User_name: H.username,
      );
    },
  );
}
