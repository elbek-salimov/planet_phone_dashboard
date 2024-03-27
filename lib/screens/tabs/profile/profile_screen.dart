import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../view_models/auth_view_model.dart';
import '../../routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: user != null
          ? context.watch<AuthViewModel>().loading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Stack(children: [
                    Container(
                      height: 120.h,
                      color: AppColors.c1317DD,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70.h, bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40.w,
                                child: ClipOval(
                                  child: Image.network(
                                    user.photoURL!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          8.getH(),
                          Text(
                            user.displayName.toString(),
                            style: AppTextStyles.sfProRoundedSemiBold,
                          ),
                          10.getH(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteNames.profileEdit);
                            },
                            child: const Text('Edit Profile'),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              context.read<AuthViewModel>().logout(context);
                            },
                            child: Text(
                              'Log Out',
                              style: AppTextStyles.sfProRoundedBold
                                  .copyWith(color: Colors.red, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                )
          : const Center(
              child: Text("USER NOT EXIST"),
            ),
    );
  }
}
