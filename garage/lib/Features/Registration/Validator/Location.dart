import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';

enum Position { empty }

class GeoPoint1 extends GeoPoint {
  final double latitude;
  final double longitude;

  const GeoPoint1({required this.latitude, required this.longitude})
      : super(0.0, 0.0);
  static const empty = GeoPoint1(latitude: 0, longitude: 0);
}

class GeoPointInput extends FormzInput<GeoPoint1, Position> {
  const GeoPointInput.pure() : super.pure(GeoPoint1.empty);
  const GeoPointInput.dirty([GeoPoint1 value = GeoPoint1.empty])
      : super.dirty(value);

  @override
  Position? validator(GeoPoint1 value) {
    return value.latitude != 0 && value.longitude != 0 ? null : Position.empty;
  }
}
