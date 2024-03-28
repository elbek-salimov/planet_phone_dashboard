import 'package:flutter/material.dart';

import '../../../utils/permissions/app_permissions.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Permissions")),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                AppPermissions.getActivityRecognitionPermission();
              },
              child: const Text("ACTIVITY"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getCameraPermission();
              },
              child: const Text("CAMERA"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getLocationPermission();
              },
              child: const Text("LOCATION"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getContactsPermission();
              },
              child: const Text("CONTACTS"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getPhonePermission();
              },
              child: const Text("PHONE"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getSensorsPermission();
              },
              child: const Text("SENSORS"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getBluetoothPermission();
              },
              child: const Text("BLUETOOTH"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getCalendarFullAccessPermission();
              },
              child: const Text("CALENDAR"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getSmsPermission();
              },
              child: const Text("SMS"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getIgnoreBatteryOptimizationPermission();
              },
              child: const Text("BATTERY"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getSomePermissions();
              },
              child: const Text("SOME PERMISSIONS"),
            ),
          ],
        ),
      ),
    );
  }
}