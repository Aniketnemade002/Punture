import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:garage/Features/Registration/Validator/Location.dart';
import 'package:garage/Features/Registration/presentation/UserRegisterpages/bloc/user_register_bloc.dart';
import 'package:garage/Features/Registration/presentation/Widgets/GeoLocation_service.dart';
import 'package:garage/Features/Registration/presentation/Widgets/loc.dart';
import 'package:garage/Fresh.dart';
import 'package:garage/auth/bloc/auth_bloc.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/validationError.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:garage/main.dart';
import 'package:lottie/lottie.dart';

class UserRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Prevent resizing when keyboard appears
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          surfaceTintColor: Kcolor.primary,
          centerTitle: true,
          leadingWidth: 100,
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Kcolor.bg),
              onPressed: () async {
                context.read<AuthBloc>().add(AuthenticationLogoutRequested());
                Future.delayed(Duration.zero, () async {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SelectScreen(),
                    ),
                    (Route route) => false,
                  );
                });
              },
              tooltip: 'Logout',
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(10, 20), // Rounded bottom edges
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 80,
              height: 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ), // Half of the width or height for a perfect circle
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ), // White border
                ),
                child: Container(
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
          title: Text("Register",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: fontstyles.Head,
                fontSize: 40,
                color: Kcolor.bg,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Kcolor.primary,
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register to unlock exclusive features and benefits!",
                      style: TextStyle(
                        fontFamily: fontstyles.Head,
                        fontSize: 15,
                        color: Kcolor.bg,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Kcolor.primary,
      body: BlocListener<UserRegisterBloc, UserRegisterState>(
        listener: (context, state) {
          if (state.status.isFailure) {
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
                      'Login Failed ',
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
          if (state.status.isSuccess) {
            RestartWidget.restartApp(context);
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.topCenter,
            color: Kcolor.primary,
            child: Container(
              constraints: BoxConstraints(maxHeight: double.infinity),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Kcolor.bg_2,
              ),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Kcolor.button,
                          ), // Icon on the left side
                        ),
                        TextSpan(
                          text:
                              '  Personal Informaion ', // Text next to the icon
                          style: TextStyle(
                            color: Kcolor.TextB,
                            fontFamily: fontstyles.Gpop,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shadowColor: Kcolor.secondary,
                    elevation: 5,
                    surfaceTintColor: Kcolor.bg,
                    color: Kcolor.bg,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NameInput(),
                          const SizedBox(height: 20),
                          _EmailInput(),
                          const SizedBox(height: 20),
                          _MobileNoInput(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.map,
                            size: 30,
                            color: Kcolor.button,
                          ), // Icon on the left side
                        ),
                        TextSpan(
                          text: '  Your Location ', // Text next to the icon
                          style: TextStyle(
                            color: Kcolor.TextB,
                            fontFamily: fontstyles.Gpop,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shadowColor: Kcolor.secondary,
                    elevation: 5,
                    surfaceTintColor: Kcolor.bg,
                    color: Kcolor.bg,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          _LocationInput(),
                          SizedBox(height: 20),
                          VillageSelector(),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.security,
                            size: 30,
                            color: Kcolor.button,
                          ), // Icon on the left side
                        ),
                        TextSpan(
                          text: '  Security PIN ', // Text next to the icon
                          style: TextStyle(
                            color: Kcolor.TextB,
                            fontFamily: fontstyles.Gpop,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shadowColor: Kcolor.secondary,
                    elevation: 5,
                    surfaceTintColor: Kcolor.bg,
                    color: Kcolor.bg,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _PINInput(),
                          const SizedBox(height: 20),
                          _ConfirmPINInput(),
                          const SizedBox(height: 20),
                          _SubmitButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisterBloc, UserRegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) =>
              context.read<UserRegisterBloc>().add(EmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText:
                state.email.isNotValid ? 'Enter a valid email address' : null,
            prefixIcon: const Icon(Icons.email),
            border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class VillageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisterBloc, UserRegisterState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LocationSelectorButton(onSelectionDone: (selectedVillage) {
              context.read<UserRegisterBloc>().add(
                    VillageChanged(selectedVillage),
                  );
            }),
            state.village.isNotValid
                ? const SizedBox(
                    child: Text(
                      " Please Select the Village ",
                      style: TextStyle(
                          fontFamily: fontstyles.Gpop, color: Colors.red),
                    ),
                  )
                : SizedBox.shrink()
          ],
        );
      },
    );
  }
}

class _LocationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisterBloc, UserRegisterState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GLButton(onLocationObtained: (geoPoint) {
              GeoPoint1 result = GeoPoint1(
                  latitude: geoPoint.latitude, longitude: geoPoint.longitude);
              context.read<UserRegisterBloc>().add(GeoLocationChanged(result));
            }),
            state.geoLocation.isNotValid
                ? const SizedBox(
                    child: Text(
                      " Please Select the Location ",
                      style: TextStyle(
                          fontFamily: fontstyles.Gpop, color: Colors.red),
                    ),
                  )
                : SizedBox.shrink()
          ],
        );
      },
    );
  }
}

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisterBloc, UserRegisterState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (ownerName) =>
              context.read<UserRegisterBloc>().add(NameChanged(ownerName)),
          decoration: InputDecoration(
            labelText: 'Your Name',
            errorText: state.name.isNotValid
                ? KError.nameErrorToString(state.name.error)
                : null,
            prefixIcon: const Icon(Icons.verified_user),
            border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class _MobileNoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisterBloc, UserRegisterState>(
      builder: (context, state) {
        return TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (mobileNo) => context
              .read<UserRegisterBloc>()
              .add(MobileNoChanged(int.parse(mobileNo.trim()))),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Mobile Number',
            errorText: state.mobileNo.isNotValid
                ? KError.mobileErrorToString(state.mobileNo.error)
                : null,
            prefixIcon: const Icon(Icons.phone),
            border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisterBloc, UserRegisterState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      state.isvalid ? Kcolor.Fbutton : Kcolor.TextB,
                  shadowColor: Kcolor.button,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onPressed: state.isvalid
                    ? () => safeOnPressed(context, () {
                          FocusScope.of(context).unfocus();
                          context
                              .read<UserRegisterBloc>()
                              .add(RegisterSubmitted());
                        })
                    : () => print("notworking"),
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontFamily: fontstyles.Gpop,
                      color: state.isvalid ? Kcolor.bg : Kcolor.C_Under_3),
                ),
              );
      },
    );
  }
}

class _PINInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisterBloc, UserRegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (_pin) =>
              context.read<UserRegisterBloc>().add(PINChanged(_pin)),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: ' Enter PIN',
            labelText: ' PIN',
            errorText: state.pin.isNotValid
                ? KError.pinErrorToString(state.pin.error)
                : null,
            prefixIcon: const Icon(Icons.lock),
            border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class _ConfirmPINInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRegisterBloc, UserRegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (pin) =>
              context.read<UserRegisterBloc>().add(ConfirmPINChanged(pin)),
          keyboardType: TextInputType.number,
          obscureText: true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            fillColor: Kcolor.Fbutton,
            prefixIconColor:
                state.confirmpin.isValid ? Kcolor.Connected : Colors.red,
            hintText: ' ReEnter PIN',
            labelText: 'confirm PIN',
            errorText: state.confirmpin.isNotValid
                ? KError.confirmPinErrorToString(state.confirmpin.error)
                : null,
            prefixIcon: const Icon(Icons.lock),
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
        );
      },
    );
  }
}
