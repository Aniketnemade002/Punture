import 'package:flutter/material.dart';
import 'package:garage/constant/OnBording/onbord.dart';
import 'package:garage/constant/constant.dart';

class OnBordUser extends StatelessWidget {
  const OnBordUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPage(
        pages: [
          OnboardingPageModel(
              title: 'Welcome To PUNCTURE',
              Quote: 'Find and Book Your Ideal Garage Slot',
              description:
                  "Unlock the Convenience of Hassle-Free Parking With just a Tap !!",
              image: 'assets/images/Animation/user/travell.json',
              bgColor: Kcolor.bg,
              textColor: Kcolor.secondary),
          OnboardingPageModel(
              title: 'Discover Nearby Garages',
              Quote: 'Explore Garages in Your Area',
              description:
                  "Explore a network of trusted garages near you, ensuring your vehicle's safety and your peace of mind.",
              image: 'assets/images/Animation/user/LOC.json',
              bgColor: Kcolor.bg,
              textColor: Kcolor.secondary),
          OnboardingPageModel(
              title: 'Book Your Slot',
              Quote: 'Reserve Your Spot in Seconds',
              description:
                  "Secure your parking space effortlessly, because every second counts when it comes to convenience.",
              image: 'assets/images/Animation/user/datebooking.json',
              bgColor: Kcolor.bg,
              textColor: Kcolor.secondary),
        ],
      ),
    );
  }
}

class onBordOwner extends StatelessWidget {
  const onBordOwner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPage(
        pages: [
          OnboardingPageModel(
              title: 'Welcome To PUNCTURE',
              Quote: 'Manage Your Garage with Ease',
              description:
                  "Effortlessly streamline your garage operations and enhance customer satisfaction with our intuitive platform !",
              image: 'assets/images/Animation/Garage/GarageGare .json',
              bgColor: Kcolor.bg,
              textColor: Kcolor.secondary),
          OnboardingPageModel(
              title: 'List Your Slots',
              Quote: 'Take control of your garages availability!! ',
              description:
                  "Unlock the Convenience of Hassle-Free Parking With just a Tap !!",
              image: 'assets/images/Animation/user/sloot.json',
              bgColor: Kcolor.bg,
              textColor: Kcolor.secondary),
          OnboardingPageModel(
              title: 'Control Your Availability',
              Quote: 'Optimize Your Schedulet',
              description:
                  "Take control of your garage's availability, maximizing efficiency and ensuring seamless service for every customer.ssssss",
              image: 'assets/images/Animation/Garage/owner.json',
              bgColor: Kcolor.bg,
              textColor: Kcolor.secondary),
        ],
      ),
    );
  }
}
