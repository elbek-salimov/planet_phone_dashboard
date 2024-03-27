class AppConstants {
  // TextField check
  static RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  static RegExp textRegExp = RegExp("[a-zA-Z]");
  static RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  // Client ID
  static String clientID =
      "699471060311-boktfei0alnfbjc140gako8vvncn4opj.apps.googleusercontent.com";

  // Market structure
  static String categories = "categories";
  static String products = "products";
  static String users = "users";
  static String notifications = "notifications";

  // FCM token
  static String fcmToken =
      'AAAA2nH49RI:APA91bGM5GQM4HsW2BcX77fnihDOuPwNxzd7p9_-DJDXMaT16V-wP0satKc-kjTbsqTBYSJpIz_70hJBGQ826QK0UCXoOOlsahqhVDBNJcK8Czm5_LhkKvh1G-PNJnDdO5E_ctvc7dTD';
}
