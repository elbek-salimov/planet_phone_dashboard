import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:planet_phone_dashboard/data/models/notification_model.dart';
import 'package:planet_phone_dashboard/screens/routes.dart';
import 'package:planet_phone_dashboard/screens/tabs/home/permissions_screen.dart';
import 'package:provider/provider.dart';

import '../../../data/api_provider/api_provider.dart';
import '../../../services/local_notification_services.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../view_models/auth_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    User? user = context.watch<AuthViewModel>().getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: AppTextStyles.sfProRoundedSemiBold,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 16.h, left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'HELLO ${user!.displayName.toString()}',
                    style:
                        AppTextStyles.sfProRoundedBold.copyWith(fontSize: 25),
                  ),
                ],
              ),
              16.getH(),
              // TextButton(
              //   onPressed: () {
              //     FirebaseMessaging.instance.subscribeToTopic("app_news");
              //   },
              //   child: const Text(
              //     "Subscribe to topic: app_news",
              //   ),
              // ),
              // TextButton(
              //   onPressed: () {
              //     FirebaseMessaging.instance.unsubscribeFromTopic("app_news");
              //   },
              //   child: const Text(
              //     "Unsubscribe from topic: app_news",
              //   ),
              // ),
              // TextButton(
              //   onPressed: () async {
              //     String messageId =
              //         await ApiProvider().sendNotificationToUsers(
              //       topicName: "news",
              //       title: "Bu test notification",
              //       body: "Yana test notiifcation",
              //     );
              //     debugPrint("MESSAGE ID:$messageId");
              //   },
              //   child: Text(
              //     "SEND MESSAGE TO USERS",
              //   ),
              // ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.sendNotification);
                },
                child: const Text('Send Notification'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const PermissionsScreen();
                  }));
                },
                child: const Text('PERMISSIONS'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
