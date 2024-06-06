import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:garage/Features/Registration/presentation/Widgets/loc.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerBookingModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerHistoryModalImpl.dart';
import 'package:garage/Features/owner/Data/ModalImpl/OwnerModalImpl.dart';
import 'package:garage/Features/owner/Prsentation/bloc/OwnerBooking_bloc/owner_booking_bloc_bloc.dart';
import 'package:garage/Features/owner/Prsentation/bloc/OwnerHistory_bloc/owner_history_bloc_bloc.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Owner_dashbord/bloc/o_dash_bord_bloc.dart';
import 'package:garage/Features/owner/Prsentation/bloc/Slot_bloc/bloc/slot_bloc.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerBookingList.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerHistoryList.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerPages.dart';
import 'package:garage/Features/owner/Prsentation/page/Slot/SlotSystem.dart';
import 'package:garage/Features/user/Prsentation/bloc/Booking_bloc/bloc/booking_bloc.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/Pages.dart';
import 'package:garage/Payment/Presentation/pages/OwnerWallet.dart';
import 'package:garage/Test.dart';
import 'package:garage/constant/Common/common.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

class OwnerDashBord extends StatefulWidget {
  @override
  _OwnerDashBordState createState() => _OwnerDashBordState();
}

class _OwnerDashBordState extends State<OwnerDashBord>
    with SingleTickerProviderStateMixin {
  late List<OwnerBookingModal> OwnerbookingItems;
  late List<OwnerHistoryModal> OwnerHistorybookingItems;
  late MainOwnerModal MainOwner;
  int _currentIndex = 0;
  bool isLoading = false;
  bool isBookingLoading = false;
  bool isHistoryLoading = false;
  bool isHDataFound = false;
  bool isBDataFound = false;
  bool _isFabVisible = true;

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    _scrollController2.addListener(_onScroll2);
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _scrollController2.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    late bool load = false;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return BlocListener<SlotBloc, SlotState>(
          listener: (context, state) {
            if (state is SlotGetFailure) {
              SlotSystemFailureDialog();
            }
            if (state is SlotAddFailure) {
              SlotSystemFailureDialog();
            }
            if (state is SlotAddSucsess) {
              context.read<SlotBloc>().add(LastSlotRequested());
              showDialog(
                  context: context, // Add the context parameter here
                  builder: (context) => Slot_Add_Sucess_Dialog());
            }
          },
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Kcolor.secondary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Text('Add New Slot ',
                      style: TextStyle(
                        fontFamily: fontstyles.Head,
                        fontSize: 30,
                        color: Kcolor.bg,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                BlocBuilder<SlotBloc, SlotState>(
                  builder: (context, state) {
                    if (state is GotLastSlot) {
                      return Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Kcolor.bg,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 2),
                          child: DateTimePicker(
                            fetchedDateTime:
                                state.SlotTimeDate, // Example fetched date/time
                          )
                          //
                          //
                          //
                          );
                    } else {
                      return Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Kcolor.bg,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 2),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Kcolor.primary,
                            ),
                          )

                          //
                          //
                          //
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isFabVisible = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isFabVisible = true;
      });
    }
  }

  void _onScroll2() {
    if (_scrollController2.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isFabVisible = false;
      });
    } else if (_scrollController2.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isFabVisible = true;
      });
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    setState(() {
      _isFabVisible = true;
    });
  }

  ///
  ///
  ///
  ///
  ///
  ///
//////\
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ODashBordBloc, ODashBordState>(
      listener: (context, state) {
        if (state is GotOwner) {
          isLoading = true;

          MainOwner = state.owner;
        }
      },
      builder: (context, state) {
        return isLoading
            ? Scaffold(
                drawerEnableOpenDragGesture: true,
                drawerEdgeDragWidth: 150,
                appBar: AppBar(
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Kcolor.bg),
                  surfaceTintColor: Kcolor.primary,
                  backgroundColor: Kcolor.secondary,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 3, 2),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50,
                            ), // Half of the width or height for a perfect circle
                          ),
                          child: Container(
                            color: Kcolor.secondary,
                            // Adjust padding if needed
                            padding: const EdgeInsets.all(2),
                            child: isuser == true
                                ? Lottie.asset(
                                    'assets/images/Animation/user/travell.json',
                                  )
                                : Lottie.asset(
                                    'assets/images/Animation/Garage/owner.json',
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  title: Text(_currentIndex == 0 ? 'Puncture' : "Hostory",
                      style: TextStyle(
                        fontFamily: fontstyles.Head,
                        fontSize: 30,
                        color: Kcolor.bg,
                        fontWeight: FontWeight.bold,
                      )),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(6, 7), // Rounded bottom edges
                    ),
                  ),
                ),
                body: LiquidPullToRefresh(
                  height: 200,
                  color: Kcolor.primary,
                  backgroundColor: Kcolor.bg,
                  showChildOpacityTransition: false,
                  springAnimationDurationInMilliseconds: 400,
                  onRefresh: () async {
                    context
                        .read<OwnerBookingBlocBloc>()
                        .add(GetOwnerBookingList());
                    context
                        .read<OwnerHistoryBlocBloc>()
                        .add(GetOwnerHistoryList());
                  },
                  child: Center(
                      child: _currentIndex == 0
                          ? BlocBuilder<OwnerBookingBlocBloc,
                              OwnerBookingBlocState>(
                              builder: (context, state) {
                                if (state is Owner_No_Data_HistorygList) {
                                  print(
                                      '++%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
                                  return Center(
                                    child: Text(
                                        'Sorry! You Have No Booking ,Yet !',
                                        style: TextStyle(
                                          fontFamily: fontstyles.Head,
                                          fontSize: 20,
                                          color: Kcolor.TextB,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  );
                                }
                                if (state is GotBookingList) {
                                  return Center(
                                      child: OwnerBookingListView(
                                    tabController: _tabController,
                                    scrollController2: _scrollController2,
                                    bookingItems: state.BookingList,
                                  )); // Show booking content
                                }

                                return Center(
                                  child: LoadingPage(),
                                );
                              },
                            )
                          : BlocBuilder<OwnerHistoryBlocBloc,
                              OwnerHistoryBlocState>(builder: (context, state) {
                              if (state is Owner_No_Data_HistorygList) {
                                return Center(
                                  child:
                                      Text('Sorry! You Have No Hisory ,Yet !',
                                          style: TextStyle(
                                            fontFamily: fontstyles.Head,
                                            fontSize: 20,
                                            color: Kcolor.TextB,
                                            fontWeight: FontWeight.bold,
                                          )),
                                );
                              }
                              if (state is GotHistorygList) {
                                return Center(
                                    child: OwnerHistoryListView(
                                        tabController: _tabController,
                                        scrollController: _scrollController,
                                        bookingItems: state
                                            .HistoryBookingList)); // Show booking content
                              }

                              return Center(
                                child: LoadingPage(),
                              );
                            })),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: Kcolor.button,
                  currentIndex: _currentIndex,
                  onTap: _onTabTapped,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.book),
                      label: 'Booking',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.history),
                      label: 'History',
                    ),
                  ],
                ),
                floatingActionButton: _isFabVisible
                    ? SizedBox(
                        width: 80,
                        height: 80,
                        child: BlocListener<SlotBloc, SlotState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          child: FittedBox(
                            child: FloatingActionButton(
                              backgroundColor: Kcolor.button,
                              onPressed: () {
                                context
                                    .read<SlotBloc>()
                                    .add(LastSlotRequested());
                                _showBottomSheet(context);
                              },
                              child: Icon(
                                Icons.add,
                                color: Kcolor.bg,
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                      )
                    : null,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                drawer: Drawer(
                  surfaceTintColor: Kcolor.bg,
                  backgroundColor: Kcolor.bg,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        curve: Curves.fastOutSlowIn,
                        decoration: BoxDecoration(
                          color: Kcolor.primary,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.shield,
                                  size: 30,
                                  color: Kcolor.bg,
                                ),
                                SizedBox(
                                  width: 240,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      ' ${MainOwner.ownername}', // Text next to the icon
                                      style: TextStyle(
                                        color: Kcolor.bg,
                                        fontFamily: fontstyles.Gpop,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 20,
                                  color: Kcolor.bg,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      ' ${MainOwner.email} : ', // Text next to the icon
                                      style: TextStyle(
                                        color: Kcolor.bg,
                                        fontFamily: fontstyles.Gpop,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: Kcolor.bg,
                                ),
                                Text(
                                  ' Ph No. :${MainOwner.mobileNo}', // Text next to the icon
                                  style: TextStyle(
                                    color: Kcolor.bg,
                                    fontFamily: fontstyles.Gpop,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.wallet),
                        title: Text('Wallet'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OwnerWallet()),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('LogOut'),
                        onTap: () {
                          showDialog(
                            context: context, // Add the context parameter here
                            builder: (context) => LogOutButton(),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.error_outline_outlined),
                        title: Text('About'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              )
            : MainLoadingPage();
      },
    );
  }
}
