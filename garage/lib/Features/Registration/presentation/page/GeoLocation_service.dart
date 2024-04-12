import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// GLButton(
//   onLocationObtained: (GeoPoint geoPoint) {
//     print("Received GeoPoint: ${geoPoint.latitude}, ${geoPoint.longitude}");
//     // You can now use this GeoPoint in your Firestore database operations
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
        ? const SizedBox(
            height: 100,
            width: 500,
            child: Row(
              children: [
                Icon(Icons.thumb_up),
                Text("Location obtained!"),
              ],
            ),
          )
        : _iserror
            ? ElevatedButton(
                onPressed: _getLocation,
                child: _loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Try Again!'),
              )
            : ElevatedButton(
                onPressed: _checkLocationPermission,
                child: _loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Get Location'),
              );
  }
}
