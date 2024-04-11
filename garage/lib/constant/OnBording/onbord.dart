import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/login.dart';
import 'package:garage/constant/constant.dart';
import 'package:lottie/lottie.dart';

class OnboardingPageModel {
  final String title;
  final String description;
  final String Quote;
  final String image;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.Quote,
      required this.image,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}

class OnboardingPage extends StatefulWidget {
  final List<OnboardingPageModel> pages;

  const OnboardingPage({Key? key, required this.pages}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final _item = widget.pages[idx];
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: Lottie.asset(
                            _item.image,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 350),
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 60, 0),
                                  child: Text(_item.title,
                                      style: TextStyle(
                                        letterSpacing: 0.3,
                                        fontSize: 30,
                                        fontFamily: 'poppin',
                                        fontWeight: FontWeight.bold,
                                        color: _item.textColor,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 350),
                                padding: const EdgeInsets.fromLTRB(1, 0, 70, 0),
                                child: Text(
                                  _item.Quote,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'poppin',
                                    fontWeight: FontWeight.bold,
                                    color: _item.textColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 350),
                                padding: EdgeInsets.zero,
                                child: Text(
                                  _item.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'poppin',
                                    color: Kcolor.Black,
                                  ),
                                ),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 20
                              : 4,
                          height: 4,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Kcolor.button,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: TextButton(
                  onPressed: () async {
                    if (_currentPage == widget.pages.length - 1) {
                      await pref!.setBool('FirstRun', false);

                      isuser == true
                          ? Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Userlogin(), //user
                              ),
                              (Route<dynamic> route) => false)
                          : Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ownerlogin(), //owner
                              ),
                              (Route<dynamic> route) => false);
                    } else {
                      _pageController.animateToPage(_currentPage + 1,
                          curve: Curves.easeInOutCubic,
                          duration: const Duration(milliseconds: 250));
                    }
                  },
                  child: Text(
                    _currentPage == widget.pages.length - 1 ? "Finish" : "Next",
                    style: TextStyle(color: Kcolor.Black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
