import 'package:cubex/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sizer {
  static double get screenWidth => 1.sw;
  static double get screenHeight => 1.sh;
  static get deviceRatio => screenHeight / screenWidth;
  static height(double height) => height.h;
  static width(double width) => width.w;
  static text(double size) => size.sp;
  static radius(double size) => size.r;
}

class XBox extends StatelessWidget {
  final double _width;

  const XBox(this._width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width.w,
    );
  }
}

///Use for height spacing
class YBox extends StatelessWidget {
  final double _height;

  const YBox(this._height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height.h,
    );
  }
}

///Use for when divider is needed
class AppDivider extends StatelessWidget {
  const AppDivider({this.color, this.thickness, super.key});

  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.grey200,
      height: 0,
      thickness: thickness,
    );
  }
}
