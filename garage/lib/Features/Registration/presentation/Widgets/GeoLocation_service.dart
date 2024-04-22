import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/constant/constant.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// GLButton(
//   onLocationObtained: (GeoPoint geoPoint) {
//     print("Received GeoPoint: ${geoPoint.latitude}, ${geoPoint.longitude}");
//     SSSS
//   },
// )

class GLButton extends StatefulWidget {
  final Function(GeoPoint)? onLocationObtained;

  GLButton({this.onLocationObtained});

  @override
  State<StatefulWidget> createState() => _GLButtonState();
}

class _GLButtonState extends State<GLButton> {
  final Location _location = Location();
  bool _loading = false;
  LocationData? _locationData;
  String? _error;
  bool _isLocGot = false;
  bool _iserror = false;

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      _getLocation();
    } else if (status.isDenied) {
      await Permission.locationWhenInUse.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Encourage user to manually allow the permission in app settings.
    }
  }

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final locationResult = await _location.getLocation();
      setState(() {
        _locationData = locationResult;
        _loading = false;
        _isLocGot = true;
        double? latitude = _locationData?.latitude;
        double? longitude = _locationData?.longitude;
        if (latitude != null && longitude != null) {
          widget.onLocationObtained?.call(GeoPoint(latitude, longitude));
          debugPrint('Latitude: $latitude, Longitude: $longitude');
        }
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
        _isLocGot = false;
        _iserror = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLocGot
        ? Container(
            height: 30,
            decoration: BoxDecoration(
              color: Kcolor.primary,
              borderRadius:
                  BorderRadius.circular(5), // Adjust the radius for round edges
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.thumb_up,
                  color: Kcolor.bg,
                ),
                SizedBox(
                    width: 5), // Adjust the spacing between the icon and text
                Text(
                  "Location obtained!",
                  style: TextStyle(
                    fontFamily: fontstyles.Gpop,
                    color: Kcolor.bg,
                  ),
                ),
              ],
            ),
          )
        : _iserror
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Kcolor.button,
                  shadowColor: Kcolor.button,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onPressed: _getLocation,
                child: _loading
                    ? const CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.white,
                      )
                    : const Text('Try Again!'),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Kcolor.button,
                  shadowColor: Kcolor.button,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onPressed: _checkLocationPermission,
                child: _loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Get Location',
                        style: TextStyle(
                            fontFamily: fontstyles.Gpop, color: Kcolor.bg),
                      ));
  }
}
