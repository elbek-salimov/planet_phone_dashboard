import 'package:flutter/material.dart';
import 'package:planet_phone_dashboard/screens/auth/widgets/global_textfield.dart';
import 'package:provider/provider.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/app_size.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../view_models/auth_view_model.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Column(
            children: [
              40.getH(),
              Icon(Icons.lock, size: width / 3, color: AppColors.c1317DD),
              36.getH(),
              const Text('Forgot Password',
                  style: AppTextStyles.sfProRoundedSemiBold),
              26.getH(),
              Text(
                  'Provide your email and we will send you a link to reset your password',
                  style:
                      AppTextStyles.sfProRoundedLight.copyWith(fontSize: 18)),
              20.getH(),
              GlobalTextField(
                title: 'Email',
                iconPath: AppImages.email,
                controller: emailController,
              ),
              7.getH(),
              25.getH(),
              Padding(
                padding: EdgeInsets.only(left: 17.w, right: 17.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    context.read<AuthViewModel>().resetPassword(
                          context,
                          email: emailController.text,
                        );
                  },
                  child: Ink(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.c1317DD,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'RESET',
                        style: AppTextStyles.sfProRoundedSemiBold.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              13.getH(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Go Back',
                  style:
                      AppTextStyles.sfProRoundedMedium.copyWith(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
