import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:planet_phone_dashboard/data/models/notification_model.dart';

import '../utils/constants/app_constants.dart';
import '../utils/utility_functions.dart';

class NotificationViewModel extends ChangeNotifier {

  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<NotificationModel> notifications = [];

  Future<void> getNotifications() async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .get()
        .then((snapshot) {
      notifications =
          snapshot.docs.map((e) => NotificationModel.fromJson(e.data())).toList();
    });
    _notify(false);
  }

  Stream<List<NotificationModel>> listenNotifications() => FirebaseFirestore.instance
      .collection(AppConstants.notifications)
      .snapshots()
      .map(
        (event) => notifications = event.docs
        .map((doc) => NotificationModel.fromJson(doc.data()))
        .toList(),
  );

  insertNotifications(NotificationModel notificationModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.notifications)
          .add(notificationModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.notifications)
          .doc(cf.id)
          .update({"doc_id": cf.id});

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }


  deleteNotification(String docId, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.notifications)
          .doc(docId)
          .delete();

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}