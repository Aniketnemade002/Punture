import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class RegistrationRepo {
  Future<GeoPoint?> getGeolocation();
}
