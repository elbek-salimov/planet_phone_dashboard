import 'package:flutter/material.dart';

double height = 0.0;
double width = 0.0;

extension SizeUtils on int {
  double get h => (this / 666) * height;

  double get w => (this / 307) * width;

  SizedBox getH() {
    return SizedBox(
      height: (this / 666) * height,
    );
  }

  SizedBox getW() {
    return SizedBox(
      width: (this / 307) * width,
    );
  }
}