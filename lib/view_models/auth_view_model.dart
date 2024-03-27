import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:planet_phone_dashboard/data/models/user_data_model.dart';

import '../screens/routes.dart';
import '../utils/constants/app_constants.dart';
import '../utils/utility_functions.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get loading => _isLoading;

  List<UserDataModel> users = [];

  User? get getUser => FirebaseAuth.instance.currentUser;

  registerUser(
    BuildContext context, {
    required String email,
    required String password,
    required String username,
  }) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      showSnackbar(
        context: context,
        message: "Fill in all the fields first",
      );
    }
    if (AppConstants.emailRegExp.hasMatch(email) &&
        AppConstants.passwordRegExp.hasMatch(password)) {
      try {
        _notify(true);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
        }

        _addNewUserToList(userCredential);

        _notify(false);
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        showErrorForRegister(e.code, context);
      } catch (error) {
        if (!context.mounted) return;
        showSnackbar(
          context: context,
          message: "Unknown error:$error.",
        );
      }
    } else {
      showSnackbar(
        context: context,
        message: "Incorrect Email or Password!",
      );
    }
  }

  loginUser(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    if (AppConstants.emailRegExp.hasMatch(email) &&
        AppConstants.passwordRegExp.hasMatch(password)) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
      } on FirebaseAuthException catch (err) {
        if (!context.mounted) return;
        showErrorForLogin(err.code, context);
      } catch (error) {
        if (!context.mounted) return;
        showSnackbar(
          context: context,
          message: "Unknown error:$error.",
        );
      }
    }
    if (email.isEmpty || password.isEmpty) {
      showSnackbar(
        context: context,
        message: "Enter Login and Password!",
      );
    } else {
      showSnackbar(
        context: context,
        message: "Incorrect Login or Password!",
      );
    }
  }

  logout(BuildContext context) async {
    _notify(true);
    await FirebaseAuth.instance.signOut();
    _notify(false);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
  }

  resetPassword(BuildContext context, {required String email}) async {
    if (AppConstants.emailRegExp.hasMatch(email)) {
      _notify(true);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _notify(false);
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: "The recovery password has been sent to your email.",
      );
    } else {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: " Incorrect email!",
      );
    }
  }

  updateUsername(String username) async {
    if(AppConstants.textRegExp.hasMatch(username)){
      _notify(true);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
      _notify(false);
    }
  }

  updatePassword(String password) async {
    if(AppConstants.passwordRegExp.hasMatch(password)){
      _notify(true);
      await FirebaseAuth.instance.currentUser!.updatePassword(password);
      _notify(false);
    }
  }

  updateEmail(String email) async {
    if(AppConstants.emailRegExp.hasMatch(email)){
      _notify(true);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      _notify(false);
    }
  }

  updateImageUrl(String imagePath) async {
    _notify(true);
    try {
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imagePath);
    } catch (error) {
      debugPrint("ERROR:$error");
    }
    _notify(false);
  }

  _addNewUserToList(UserCredential userCredential) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    var user =
    await FirebaseFirestore.instance.collection(AppConstants.users).add({
      "user_id": userCredential.user != null ? userCredential.user!.uid : "",
      "user_name":
      userCredential.user != null ? userCredential.user!.displayName : "",
      "email": userCredential.user != null ? userCredential.user!.email : "",
      "image_url":
      userCredential.user != null ? userCredential.user!.photoURL : "",
      "fcm_token": fcmToken ?? "",
      "user_doc_id": "",
    });
    await FirebaseFirestore.instance
        .collection(AppConstants.users)
        .doc(user.id)
        .update({"user_doc_id": user.id});
  }

  Future<void> getUserData() async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.users)
        .get()
        .then((snapshot) {
      users =
          snapshot.docs.map((e) => UserDataModel.fromJson(e.data())).toList();
    });
    _notify(false);
  }

  Stream<List<UserDataModel>> listenNotifications() => FirebaseFirestore.instance
      .collection(AppConstants.users)
      .snapshots()
      .map(
        (event) => users = event.docs
        .map((doc) => UserDataModel.fromJson(doc.data()))
        .toList(),
  );

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  //TODO 6
  // Google authorization
  Future<void> signInWithGoogle(BuildContext context,
      [String? clientId]) async {
    _notify(true);

    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(clientId: clientId).signIn();

      // Check if user cancelled the sign-in process
      if (googleUser == null) {
        _notify(false);
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      _notify(false);
      if (userCredential.user != null) {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
      }
    } catch (error) {
      // Handle errors here
      debugPrint("Error signing in with Google: $error");
      _notify(false);
    }
  }

}
