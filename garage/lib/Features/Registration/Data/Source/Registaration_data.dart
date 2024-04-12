import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:location/location.dart';

abstract interface class RemoteRegistration {
  Future<GeoPoint?> getGeoLocation();
}

class RemoteRegistrationImpl implements RemoteRegistration {
  final Location _location = Location();
  @override
  Future<GeoPoint?> getGeoLocation() async {
    try {
      final locationResult = await _location.getLocation();

      if (locationResult.latitude != null && locationResult.longitude != null) {
        double? _latitude = locationResult.latitude;
        double? _longitude = locationResult.longitude;

        final result = GeoPoint(_latitude!, _longitude!);

        return result;
      } else {
        return null;
      }
    } catch (e) {
      Failure.handle("Faild GeoLocation!!");
    }
  }
}
