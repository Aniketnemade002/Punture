import 'package:flutter/material.dart';
import 'package:garage/constant/Common/Webloc.dart';
import 'package:garage/constant/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fontstyles;
    return Scaffold(
      backgroundColor: Kcolor.bg,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/Animation/loadingGaer.json',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text(
                'Loading...',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      backgroundColor: Kcolor.bg,
      surfaceTintColor: Kcolor.bg,
      title: Row(
        children: [
          Icon(
            Icons.info,
            size: 25,
            color: Kcolor.button,
          ), // Icon
          Text('Loading'),
        ],
      ),
      content: SizedBox(
        child: CircularProgressIndicator(
          color: Kcolor.Fbutton,
        ),
        height: 50,
        width: 50,
      ),
    );
  }
}

class MainLoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fontstyles;
    return Scaffold(
      backgroundColor: Kcolor.bg,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/Animation/CarBooking.json',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text(
                'Loading...',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OutlinedTextFieldExample extends StatelessWidget {
  const OutlinedTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        labelText: 'Outlined',
        hintText: 'hint text',
        helperText: 'supporting text',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class CustomOutlinedTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String helperText;

  const CustomOutlinedTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.helperText,
  }) : super(key: key);

  @override
  _CustomOutlinedTextFieldState createState() =>
      _CustomOutlinedTextFieldState();
}

class _CustomOutlinedTextFieldState extends State<CustomOutlinedTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: widget.helperText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: _isFocused ? Colors.red : Colors.black,
              width: _isFocused ? 2.0 : 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

// RichText(
//                   textAlign: TextAlign.left,
//                   text: TextSpan(
//                     children: [
//                       WidgetSpan(
//                         alignment: PlaceholderAlignment.middle,
//                         child: Icon(Icons.person,
//                             size: 30,
//                             color: Kcolor.button), // Icon on the left side
//                       ),
//                       TextSpan(
//                         text: 'Personal Informaion ', // Text next to the icon
//                         style: TextStyle(
//                           color: Kcolor.TextB,
//                           fontFamily: fontstyles.Gpop,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 25,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

class LocationButton extends StatelessWidget {
  final String inputKey;
  final double long;
  final double lat;
  final String Location;

  LocationButton({
    required this.inputKey,
    required this.long,
    required this.lat,
    required this.Location,
  }) : super(key: ObjectKey(inputKey));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        backgroundColor: Kcolor.Fbutton,
        shadowColor: Kcolor.button,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
      onPressed: () async {
        final availableMaps = await MapLauncher.installedMaps.then((value) =>
            value.first.showMarker(coords: Coords(lat, long), title: Location));

        // final ismapok =
        //     await MapLauncher.isMapAvailable(MapType.google) ?? false;

        // if (ismapok) {
        //   await MapLauncher.showMarker(
        //       mapType: MapType.google,
        //       coords: Coords(37.759392, -122.5107336),
        //       title: "Location");
        // }

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => WebViewPage(
        //         url:
        //             'https://www.google.com/maps/search/?api=1&query=${lat},${long}'),
        //   ),
        // );
      },
      child: Icon(
        size: 25,
        Icons.telegram,
        color: Kcolor.bg,
      ),
    );
  }
}
