import 'package:flutter/material.dart';
import 'package:planet_phone_dashboard/screens/auth/widgets/global_passwordfield.dart';
import 'package:planet_phone_dashboard/screens/auth/widgets/global_textfield.dart';
import 'package:provider/provider.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/app_size.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../utils/utility_functions.dart';
import '../../view_models/auth_view_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 22.h, left: 35.w, right: 35.w),
          child: Column(
            children: [
              Image.asset(AppImages.signUp),
              30.getH(),
              const Text('ADMIN Sign Up',
                  style: AppTextStyles.sfProRoundedSemiBold),
              16.getH(),
              GlobalTextField(
                title: 'Username',
                iconPath: AppImages.profile,
                controller: usernameController,
              ),
              7.getH(),
              GlobalTextField(
                title: 'Email',
                iconPath: AppImages.email,
                controller: emailController,
              ),
              7.getH(),
              GlobalPasswordField(
                title: 'Password',
                iconPath: AppImages.password,
                controller: passwordController,
              ),
              7.getH(),
              GlobalPasswordField(
                title: 'Confirm Password',
                iconPath: AppImages.password,
                controller: confirmPasswordController,
              ),
              33.getH(),
              Padding(
                padding: EdgeInsets.only(left: 17.w, right: 17.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      context.read<AuthViewModel>().registerUser(
                            context,
                            email: emailController.text,
                            password: passwordController.text,
                            username: usernameController.text,
                          );
                    } else {
                      showSnackbar(
                        context: context,
                        message: "Check Confirm Password!",
                      );
                    }
                  },
                  child: Ink(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.c1317DD,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'SIGNUP',
                        style: AppTextStyles.sfProRoundedSemiBold.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              15.getH(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: AppTextStyles.sfProRoundedRegular.copyWith(
                      fontSize: 12,
                      color: AppColors.c131212.withOpacity(0.8),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                    },
                    child: Text(
                      'Login',
                      style: AppTextStyles.sfProRoundedRegular.copyWith(
                        fontSize: 12,
                        color: AppColors.c1317DD,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
