import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField({
    super.key,
    required this.title,
    required this.iconPath,
    required this.controller,
  });

  final String title;
  final String iconPath;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;


    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 3.30,
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, 3.30),
        )
      ]),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 3) {
            return 'Incorrect email';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: EdgeInsets.all(12.w),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 8.w, left: 12.w),
            child: SvgPicture.asset(
              iconPath,
              colorFilter:
                  const ColorFilter.mode(AppColors.c1317DD, BlendMode.srcIn),
            ),
          ),
          hintText: title,
          hintStyle: AppTextStyles.sfProRoundedRegular,
        ),
      ),
    );
  }
}
