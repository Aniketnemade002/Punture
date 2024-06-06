import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
import 'package:garage/Features/user/Prsentation/bloc/UserDash_bloc/bloc/user_dash_bloc.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/Pages.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';

class UserHistoryListView extends StatelessWidget {
  final List<UserHistoryModal> HistoryItems;
  final TabController tabController;
  final ScrollController scrollController;

  UserHistoryListView({
    required this.HistoryItems,
    required this.scrollController,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDashBloc, UserDashState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                indicatorColor: Kcolor.secondary,
                labelColor: Kcolor.button,
                tabs: [
                  Tab(text: 'Your History'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    state is User_No_Data_HistorygList
                        ? Center(
                            child: Text('Sorry! You Have No Hisory ,Yet !',
                                style: TextStyle(
                                  fontFamily: fontstyles.Head,
                                  fontSize: 20,
                                  color: Kcolor.TextB,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                        : _buildHistoryListView(HistoryItems, scrollController),
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

Widget _buildHistoryListView(
    List<UserHistoryModal> Historys, ScrollController _scrollController) {
  return ListView.builder(
    controller: _scrollController,
    itemCount: Historys.length,
    itemBuilder: (context, index) {
      final History = Historys[index];
      return UserHistoryContainer(
        garage_owner: History.ownername,
        garge_name: History.garageName,
        Vehical_No: History.Vehical_No,
        phoneno: History.OwnerMobileNo,
        bookingtime: History.SlotTime.toDate(),
        Discription: History.Discription,
        cost: History.serviceCost,
      );
    },
  );
}
