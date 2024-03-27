import 'package:flutter/material.dart';
import 'package:planet_phone_dashboard/screens/splash/splash_screen.dart';
import 'package:planet_phone_dashboard/screens/tabs/categories/add_category_screen.dart';
import 'package:planet_phone_dashboard/screens/tabs/categories/edit_category_screen.dart';
import 'package:planet_phone_dashboard/screens/tabs/home/send_notification_screen.dart';
import 'package:planet_phone_dashboard/screens/tabs/products/add_product_screen.dart';
import 'package:planet_phone_dashboard/screens/tabs/products/edit_product_screen.dart';
import 'package:planet_phone_dashboard/screens/tabs/profile/profile_edit_screen.dart';
import 'package:planet_phone_dashboard/screens/tabs/tab_screen.dart';
import 'auth/login_screen.dart';
import 'auth/password_reset_screen.dart';
import 'auth/register_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      case RouteNames.loginRoute:
        return navigate(const LoginScreen());

      case RouteNames.registerRoute:
        return navigate(const RegisterScreen());

      case RouteNames.passwordReset:
        return navigate(const PasswordResetScreen());

      case RouteNames.profileEdit:
        return navigate(const ProfileEditScreen());

      case RouteNames.addCategory:
        return navigate(const AddCategoryScreen());

      case RouteNames.sendNotification:
        return navigate(const SendNotificationScreen());

      case RouteNames.editCategory:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return navigate(EditCategoryScreen(
          categoryName: map['categoryName'] as String,
          imageAddress: map['imageAddress'] as String,
          docId: map['docId'] as String,
        ));

      case RouteNames.addProduct:
        return navigate(const AddProductScreen());

      case RouteNames.editProduct:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return navigate(EditProductScreen(
          productName: map['productName'] as String,
          productPrice: map['productPrice'] as double,
          productDescription: map['productDescription'] as String,
          imageAddress: map['imageAddress'] as String,
          docId: map['docId'] as String,
          categoryName: map['categoryName'] as String,
        ));

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String loginRoute = "/login_route";
  static const String registerRoute = "/register_route";
  static const String passwordReset = "/passwordReset_route";
  static const String profileEdit = "/profileEdit_route";
  static const String addCategory = "/addCategory_route";
  static const String editCategory = "/editCategory_route";
  static const String addProduct = "/addProduct_route";
  static const String editProduct = "/editProduct_route";
  static const String sendNotification = "/sendNotification_route";
}
