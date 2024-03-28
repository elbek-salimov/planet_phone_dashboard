import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:planet_phone_dashboard/screens/routes.dart';
import 'package:planet_phone_dashboard/services/local_notification_services.dart';
import 'package:planet_phone_dashboard/view_models/auth_view_model.dart';
import 'package:planet_phone_dashboard/view_models/category_view_model.dart';
import 'package:planet_phone_dashboard/view_models/image_view_model.dart';
import 'package:planet_phone_dashboard/view_models/notification_view_model.dart';
import 'package:planet_phone_dashboard/view_models/product_view_model.dart';
import 'package:planet_phone_dashboard/view_models/tab_view_model.dart';
import 'package:provider/provider.dart';
import 'services/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
      "BACKGROUND MODE DA PUSH NOTIFICATION KELDI:${message.notification!.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Subscribing to topics
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.subscribeToTopic("news");
  FirebaseMessaging.instance.setAutoInitEnabled(true);

  // Background message
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoriesViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => ImageViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {

    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
      navigatorKey: navigatorKey,
    );
  }
}
