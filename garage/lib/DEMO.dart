import 'package:flutter/material.dart';
import 'package:garage/Features/owner/Data/RepoImp/MainOwnerRepoImpl.dart';
import 'package:garage/Features/user/Data/RepoImp/MainUserImpl.dart';
import 'package:garage/auth/Data/RepoImp/AuthRepoImpl.dart';
import 'package:garage/auth/Data/RepoImp/UserRepoImpl.dart';

class SampleWidget extends StatelessWidget {
  UserRepoImpl _UserRepo = UserRepoImpl();
  AuthRepoImpl _auth = AuthRepoImpl();
  MainOwnerRepoImpl _mainOwnerRepo = MainOwnerRepoImpl();
  MainUserRepoImpl _mainUserRepo = MainUserRepoImpl();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sample Widget'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _navigateToUserDash(context);
            },
            child: Text('Navigate to User Dash'),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToUserDash(BuildContext context) async {
    final mainUserResult = await _mainUserRepo.GetUser();
    var _isProfileCompleted;
    print("App call _mainUserRepo   +++++++++++");
    mainUserResult.fold(
      (l) {
        print("App Error _mainUserRepo  ");
      },
      (r) {
        _isProfileCompleted = r!.isProfileCompleted;
        if (r!.isProfileCompleted) {
          print("=================== In App  User ======");
        } else {
          print("=================== OUT App USER  ======");
        }
      },
    );
  }
}
