import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:garage/Features/Registration/presentation/Widgets/loc.dart';
import 'package:garage/Features/owner/Prsentation/page/OwnerDashbord/OwnerPages.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingHistory.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserBookingModalIMPL.dart';
import 'package:garage/Features/user/Data/ModalImpl/UserModalImpl.dart';
import 'package:garage/Features/user/Prsentation/bloc/Booking_bloc/bloc/booking_bloc.dart';
import 'package:garage/Features/user/Prsentation/bloc/UserDash_bloc/bloc/user_dash_bloc.dart';
import 'package:garage/Features/user/Prsentation/page/Booking/GaragPage.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/UserBookingList.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/Pages.dart';
import 'package:garage/Features/user/Prsentation/page/UserDash/UserHistoryList.dart';
import 'package:garage/Payment/Presentation/pages/UserWallet.dart';
import 'package:garage/Test.dart';
import 'package:garage/constant/Common/common.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

class UserDashBord extends StatefulWidget {
  @override
  _UserDashBordState createState() => _UserDashBordState();
}

class _UserDashBordState extends State<UserDashBord>
    with SingleTickerProviderStateMixin {
  late List<UserBookingDataModal> UserbookingItems;
  late List<UserHistoryModal> UserHistorybookingItems;
  late MainUserModal MainUser = TestUser;
  int _currentIndex = 0;
  bool _isFabVisible = true;
  bool isLoading = false;
  bool isBookingLoading = false;
  bool isHistoryLoading = false;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
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
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            return Container(
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
                    child: Text('Choose Your Location',
                        style: TextStyle(
                          fontFamily: fontstyles.Head,
                          fontSize: 30,
                          color: Kcolor.bg,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  // state is FeatchedGaragesLoading
                  //     ?

                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.494,
                    decoration: BoxDecoration(
                      color: Kcolor.bg,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),

                    padding: EdgeInsets.only(top: 2),
                    child: UserVillageSelector(),
                    //
                    //
                    //
                  )
                  // : Container(
                  //     width: double.infinity,
                  //     height: MediaQuery.of(context).size.height * 0.494,
                  //     decoration: BoxDecoration(
                  //       color: Kcolor.bg,
                  //       borderRadius: BorderRadius.vertical(
                  //         top: Radius.circular(20),
                  //       ),
                  //     ),
                  //     padding: EdgeInsets.only(top: 2),
                  //     child: LoadingPage()
                  //     //
                  //     //
                  //     //
                  //     ),
                ],
              ),
            );
          },
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
    return BlocConsumer<UserDashBloc, UserDashState>(
      listener: (context, state) {
        if (state is GotUser) {
          isLoading = true;
          MainUser = state.user;
        }

        if (state is GotBookingList) {
          isBookingLoading = true;
          UserbookingItems = state.BookingList;
          print(
              "+++++++++++++++++++++++++++++++++++++++++++=${state.BookingList.length}");
        }
        if (state is GotHistorygList) {
          isHistoryLoading = true;
          UserHistorybookingItems = state.HistoryBookingList;
        }
      },
      builder: (context, state) {
        return
            //  isLoading
            //     ?

            Scaffold(
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
            title: Text(_currentIndex == 0 ? 'Puncture' : 'History',
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
            height: 70,
            color: Kcolor.secondary,
            backgroundColor: Kcolor.bg,
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 200,
            onRefresh: () async {
              // context.read<UserDashBloc>().add(GetUserBookingList());
              // context.read<UserDashBloc>().add(GetUserHistoryList());
            },
            child: Center(
                child: _currentIndex == 0
                    ? LoadingPage()
                    : UserHistoryListView(
                        tabController: _tabController,
                        scrollController: _scrollController,
                        HistoryItems: TestUHistoy)

                // ? isBookingLoading
                //     ? UserBookingListView(
                //         tabController: _tabController,
                //         scrollController2: _scrollController2,
                //         bookingItems: TestBooking,
                //       )
                //     : LoadingPage() // Show booking content
                // : isHistoryLoading
                // ? UserHistoryListView(
                //     scrollController: _scrollController,
                //     HistoryItems: TestUHistoy)
                // : LoadingPage(), // Show history content
                ),
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
                  child: FittedBox(
                    child: FloatingActionButton(
                      backgroundColor: Kcolor.button,
                      onPressed: () => safeOnPressed(context, () {
                        _showBottomSheet(context);
                      }),
                      child: Icon(
                        Icons.add,
                        color: Kcolor.bg,
                      ),
                      shape: CircleBorder(),
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
                                ' ${MainUser.name}', // Text next to the icon
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
                                ' ${MainUser.email} : ', // Text next to the icon
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
                            ' Ph No. : ${MainUser.mobileNo} ', // Text next to the icon
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
                      MaterialPageRoute(builder: (context) => UserWallet()),
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
        );
        // : MainLoadingPage();
      },
    );
  }
}

class UserVillageSelector extends StatefulWidget {
  @override
  _UserVillageSelectorState createState() => _UserVillageSelectorState();
}

class _UserVillageSelectorState extends State<UserVillageSelector> {
  late bool _selected = false;
  late String _Village = '';
  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is FeatchedGaragesFaild) {
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
        if (state is FeatchedGarages) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GaragePage(
                      Garages: state.GarageList,
                    )),
          );
        }

        ///
        ///
        ///
        ///
        ///
        ///
        ///
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SearchVillageButton(onSelectionDone: (selectedVillage) {
            print(selectedVillage);
            if (selectedVillage != null) {
              _Village = selectedVillage;
              setState(() {
                _selected = true;
              });
            }
          }),
          _selected
              ? SizedBox(
                  width: 127,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Kcolor.Fbutton,
                        shadowColor: Kcolor.button,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GaragePage(
                                    Garages: TestGarages,
                                  )));
                      // context
                      //     .read<BookingBloc>()
                      //     .add(GetGarages(VillageName: _Village));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Kcolor.bg,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            fontFamily: fontstyles.Gpop,
                            fontSize: 15,
                            color: Kcolor.bg,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
