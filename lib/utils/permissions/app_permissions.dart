import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static getActivityRecognitionPermission() async {
    PermissionStatus status = await Permission.activityRecognition.status;
    debugPrint("ACTIVITY STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.activityRecognition.request();
      debugPrint("ACTIVITY STATUS AFTER ASK:$status");
    }
  }

  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    debugPrint("CAMERA STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      debugPrint("CAMERA STATUS AFTER ASK:$status");
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    debugPrint("LOCATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
      debugPrint("LOCATION STATUS AFTER ASK:$status");
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getSensorsPermission() async {
    PermissionStatus status = await Permission.sensors.status;
    debugPrint("SENSORS STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.sensors.request();
      debugPrint("SENSORS STATUS AFTER ASK:$status");
    }
  }

  static getPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;
    debugPrint("PHONE STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.phone.request();
      debugPrint("PHONE STATUS AFTER ASK:$status");
    }
  }

  static getIgnoreBatteryOptimizationPermission() async {
    PermissionStatus status = await Permission.ignoreBatteryOptimizations.status;
    debugPrint("BATTERY OPTIMIZATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.ignoreBatteryOptimizations.request();
      debugPrint("BATTERY OPTIMIZATION STATUS AFTER ASK:$status");
    }
  }

  static getBluetoothPermission() async {
    PermissionStatus status = await Permission.bluetoothConnect.status;
    debugPrint("BLUETOOTH STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.bluetoothConnect.request();
      debugPrint("BLUETOOTH STATUS AFTER ASK:$status");
    }
  }

  static getSmsPermission() async {
    PermissionStatus status = await Permission.sms.status;
    debugPrint("SMS ALERTS STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.sms.request();
      debugPrint("SMS ALERTS STATUS AFTER ASK:$status");
    }
  }

  static getCalendarFullAccessPermission() async {
    PermissionStatus status = await Permission.calendarFullAccess.status;
    debugPrint("CALENDAR FULL ACCESS STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.calendarFullAccess.request();
      debugPrint("CALENDAR FULL ACCESS STATUS AFTER ASK:$status");
    }
  }

  static getSomePermissions() async {
    List<Permission> permissions = [
      Permission.calendarWriteOnly,
      Permission.sms,
      Permission.speech,
      Permission.audio,
      Permission.microphone,
    ];
    Map<Permission, PermissionStatus> somePermissionsResults =
    await permissions.request();

    debugPrint(
        "CALENDAR STATUS AFTER ASK:${somePermissionsResults[Permission.calendarWriteOnly]}");
    debugPrint(
        "SMS STATUS AFTER ASK:${somePermissionsResults[Permission.sms]}");
    debugPrint(
        " SPEECH AFTER ASK:${somePermissionsResults[Permission.speech]}");
    debugPrint(
        " SPEECH AFTER ASK:${somePermissionsResults[Permission.audio]}");
    debugPrint(
        " SPEECH AFTER ASK:${somePermissionsResults[Permission.microphone]}");
  }
}