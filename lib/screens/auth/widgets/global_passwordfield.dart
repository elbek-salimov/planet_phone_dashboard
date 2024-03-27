import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

class GlobalPasswordField extends StatefulWidget {
  const GlobalPasswordField({
    super.key,
    required this.title,
    required this.iconPath,
    required this.controller,
  });

  final String title;
  final String iconPath;
  final TextEditingController controller;

  @override
  State<GlobalPasswordField> createState() => _GlobalPasswordFieldState();
}

class _GlobalPasswordFieldState extends State<GlobalPasswordField> {
  bool isVisible = true;

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
      child: TextField(
        textInputAction: TextInputAction.next,
        controller: widget.controller,
        obscureText: isVisible,
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
            child: SvgPicture.asset(widget.iconPath),
          ),
          suffixIcon: Material(
            color: Colors.transparent,
            child: Ink(
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
                child: isVisible
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.visibility_off),
              ),
            ),
          ),
          hintText: widget.title,
          hintStyle: AppTextStyles.sfProRoundedRegular,
        ),
      ),
    );
  }
}
