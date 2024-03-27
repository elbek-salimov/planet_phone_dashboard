import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:planet_phone_dashboard/screens/auth/widgets/global_textfield.dart';
import 'package:planet_phone_dashboard/utils/images/app_images.dart';
import 'package:planet_phone_dashboard/view_models/auth_view_model.dart';
import 'package:planet_phone_dashboard/view_models/notification_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/api_provider/api_provider.dart';
import '../../../data/models/notification_model.dart';
import '../../../services/local_notification_services.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../utils/utility_functions.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  String fcmToken = "";
  bool _switchValue = true;
  bool _isVisible = false;
  String? dropdownValue;

  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");
    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken : ${token.toString()}");
    LocalNotificationService.localNotificationService;
    //Foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNotification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
          );

          debugPrint(
              "FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );
    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      debugPrint("ON MESSAGE OPENED APP:${remoteMessage.notification!.title}");
    });
    // Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("TERMINATED:${message.notification?.title}");
      }
    });
  }

  @override
  void initState() {
    init();
    context.read<AuthViewModel>().getUserData();
    super.initState();
  }

  // Notification controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Notification data controllers
  TextEditingController newsTitleController = TextEditingController();
  TextEditingController newsDescriptionController = TextEditingController();
  TextEditingController newsImageController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    newsTitleController.dispose();
    newsDescriptionController.dispose();
    newsImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Notification',
          style: AppTextStyles.sfProRoundedSemiBold,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Notification:'),
              5.getH(),
              GlobalTextField(
                title: 'Notification title',
                iconPath: AppImages.title,
                controller: titleController,
              ),
              15.getH(),
              GlobalTextField(
                title: 'Notification description',
                iconPath: AppImages.description,
                controller: descriptionController,
              ),
              20.getH(),
              const Text('Notification Data:'),
              5.getH(),
              GlobalTextField(
                title: 'News title',
                iconPath: AppImages.title,
                controller: newsTitleController,
              ),
              15.getH(),
              GlobalTextField(
                title: 'News description',
                iconPath: AppImages.description,
                controller: newsDescriptionController,
              ),
              15.getH(),
              GlobalTextField(
                title: 'News imageUrl',
                iconPath: AppImages.photo,
                controller: newsImageController,
              ),
              15.getH(),
              Visibility(
                visible: _isVisible,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.30,
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 3.30),
                        )
                      ]),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12.w),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    hint: const Text('Select user'),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: context
                        .read<AuthViewModel>()
                        .users
                        .map((users) {
                      return DropdownMenuItem<String>(
                        value: users.fcmToken,
                        child: Text(users.email),
                      );
                    }).toList(),
                  ),
                ),
              ),
              15.getH(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Single user'),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      activeColor: AppColors.c1317DD,
                      value: _switchValue,
                      onChanged: (v) {
                        setState(() {
                          _switchValue = v;
                          _isVisible = !_isVisible;
                        });
                      },
                    ),
                  ),
                  const Text('All users'),
                ],
              ),
              10.getH(),
              SizedBox(
                width: width - 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () async {
                    String messageId =
                        await ApiProvider().sendNotificationToUsers(
                            notificationModel: NotificationModel(
                      to: fcmToken,
                      notification: NotificationSet(
                        title: titleController.text,
                        body: descriptionController.text,
                        sound: "default",
                        priority: "high",
                      ),
                      data: Data(
                        newsTitle: newsTitleController.text,
                        newsText: newsDescriptionController.text,
                        newsImage: newsImageController.text,
                      ),
                    ));
                    debugPrint("MESSAGE ID:$messageId");
          
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      if (!context.mounted) return;
                      context.read<NotificationViewModel>().insertNotifications(
                            NotificationModel(
                              to: fcmToken,
                              notification: NotificationSet(
                                title: titleController.text,
                                body: descriptionController.text,
                              ),
                              data: Data(
                                newsTitle: newsTitleController.text,
                                newsText: newsDescriptionController.text,
                                newsImage: newsImageController.text,
                              ),
                            ),
                            context,
                          );
                      showSnackbar(
                        context: context,
                        message: "Notification Sent",
                      );
                    } else {
                      if (!context.mounted) return;
                      showSnackbar(
                        context: context,
                        message: "Enter Category name and image address!",
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Go Back',
                    style: AppTextStyles.sfProRoundedBold.copyWith(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
