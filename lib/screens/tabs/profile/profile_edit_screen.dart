import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planet_phone_dashboard/screens/tabs/profile/widgets/profile_photo_view.dart';
import 'package:provider/provider.dart';

import '../../../utils/images/app_images.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../view_models/auth_view_model.dart';
import '../../auth/widgets/global_textfield.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    User? user = context.watch<AuthViewModel>().getUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Edit Profile',
                style: AppTextStyles.sfProRoundedBold.copyWith(fontSize: 24),
              ),
              15.getH(),
              ProfilePhotoView(photoUrl: user!.photoURL!),
              20.getH(),
              const Row(
                children: [
                  Text(
                    'Enter new name:',
                    style: AppTextStyles.sfProRoundedLight,
                  ),
                ],
              ),
              5.getH(),
              GlobalTextField(
                title: user.displayName.toString(),
                iconPath: AppImages.profile,
                controller: nameController,
              ),
              24.getH(),
              const Row(
                children: [
                  Text(
                    'Enter new password:',
                    style: AppTextStyles.sfProRoundedLight,
                  ),
                ],
              ),
              5.getH(),
              GlobalTextField(
                title: '* * * * * *',
                iconPath: AppImages.password,
                controller: passwordController,
              ),
              24.getH(),
              const Row(
                children: [
                  Text(
                    'Enter new email:',
                    style: AppTextStyles.sfProRoundedLight,
                  ),
                ],
              ),
              5.getH(),
              GlobalTextField(
                title: user.email.toString(),
                iconPath: AppImages.email,
                controller: emailController,
              ),
              24.getH(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    context
                        .read<AuthViewModel>()
                        .updateUsername(nameController.text);
                    context
                        .read<AuthViewModel>()
                        .updatePassword(passwordController.text);
                    context
                        .read<AuthViewModel>()
                        .updateEmail(emailController.text);
                  },
                  child: Text(
                    'SUBMIT',
                    style: AppTextStyles.sfProRoundedSemiBold
                        .copyWith(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              30.getH(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Go Back',
                  style: AppTextStyles.sfProRoundedBold.copyWith(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
