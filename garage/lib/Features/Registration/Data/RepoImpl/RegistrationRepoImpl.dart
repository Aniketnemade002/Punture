import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage/Features/Registration/Data/Source/Registaration_data.dart';
import 'package:garage/Features/Registration/Domain/repo/RegistrationRepo.dart';
import 'package:garage/core/Error/Error.dart';
import 'package:permission_handler/permission_handler.dart';

class RegistrationRepoImpl implements RegistrationRepo {
  RemoteRegistrationImpl _Register = RemoteRegistrationImpl();

  @override
  Future<GeoPoint?> getGeolocation() async {
    try {
      final status = await Permission.locationWhenInUse.status;

      if (status.isGranted) {
        final result = await _Register.getGeoLocation();
        if (result != null) {
          return result;
        } else {
          return null;
        }
      } else if (status.isDenied) {
        await Permission.locationWhenInUse.request();
        final result = await _Register.getGeoLocation();
        if (result != null) {
          return result;
        } else {
          return null;
        }
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
        final result = await _Register.getGeoLocation();
        if (result != null) {
          return result;
        } else {
          return null;
        }
      }
    } catch (e) {
      Failure.handle("Faild GeoLocation!!");
      return null;
    }
  }
}
