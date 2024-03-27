import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:planet_phone_dashboard/data/models/notification_model.dart';
import 'package:planet_phone_dashboard/utils/constants/app_constants.dart';

class ApiProvider {
  Future<String> sendNotificationToUsers({
    required NotificationModel notificationModel,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Authorization":
              "key=${AppConstants.fcmToken}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(notificationModel.toJson()),
      );
      if (response.statusCode == HttpStatus.ok) {
        debugPrint("DATA:${response.body}");
        return response.body.toString();
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return "ERROR";
  }
}
