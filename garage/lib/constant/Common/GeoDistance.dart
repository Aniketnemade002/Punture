import 'dart:math';

class GeoDistance {
  static double distanceBetween(
      double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371; // in km

    final lat1Rad = degreesToRadians(lat1);
    final lon1Rad = degreesToRadians(lon1);
    final lat2Rad = degreesToRadians(lat2);
    final lon2Rad = degreesToRadians(lon2);

    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = earthRadius * c;

    return distance;

    // return distance; // in km
  }

  static double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
