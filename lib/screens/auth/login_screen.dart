import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planet_phone_dashboard/screens/auth/widgets/global_passwordfield.dart';
import 'package:planet_phone_dashboard/screens/auth/widgets/global_textfield.dart';
import 'package:provider/provider.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/app_size.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../view_models/auth_view_model.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _switchValue = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        child: Column(
          children: [
            Image.asset(AppImages.login),
            16.getH(),
            const Text('ADMIN LOGIN', style: AppTextStyles.sfProRoundedSemiBold),
            16.getH(),
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
            13.getH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.6,
                  child: CupertinoSwitch(
                    activeColor: AppColors.c1317DD,
                    value: _switchValue,
                    onChanged: (v) {
                      setState(() {
                        _switchValue = v;
                      });
                    },
                  ),
                ),
                Text(
                  'Remember Me',
                  style: AppTextStyles.sfProRoundedRegular.copyWith(
                    fontSize: 12,
                    color: AppColors.c131212.withOpacity(0.8),
                  ),
                ),
                26.getW(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.passwordReset);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyles.sfProRoundedRegular.copyWith(
                      fontSize: 12,
                      color: AppColors.c131212.withOpacity(0.8),
                    ),
                  ),
                )
              ],
            ),
            25.getH(),
            Padding(
              padding: EdgeInsets.only(left: 17.w, right: 17.w),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  context.read<AuthViewModel>().loginUser(
                    context,
                    email: emailController.text,
                    password: passwordController.text,
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
                      'LOGIN',
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
            Text(
              'OR',
              style: AppTextStyles.sfProRoundedRegular.copyWith(
                fontSize: 12,
                color: AppColors.c131212.withOpacity(0.8),
              ),
            ),
            7.getH(),
            Text(
              'Log in with',
              style: AppTextStyles.sfProRoundedRegular.copyWith(fontSize: 12),
            ),
            12.getH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<AuthViewModel>().signInWithGoogle(context);
                  },
                  icon: SvgPicture.asset(AppImages.google),
                ),
                30.getW(),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppImages.apple),
                ),
                30.getW(),
                IconButton(
                  onPressed: () {
                  },
                  icon: SvgPicture.asset(AppImages.facebook),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account?',
                  style: AppTextStyles.sfProRoundedRegular.copyWith(
                    fontSize: 12,
                    color: AppColors.c131212.withOpacity(0.8),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.registerRoute,
                    );
                  },
                  child: Text(
                    'Register now',
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
    );
  }
}
