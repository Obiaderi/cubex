import 'package:flutter/material.dart';

class AppColors {
  static const Color transparent = Colors.transparent;

  static const Color brandBlue = Color(0xff003366);
  static const Color brandOrange = Color(0xffFE6600);
  static const Color brandBlack = Color(0xff000B23);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color black12 = Colors.black12;
  static const Color blue = Color(0xff003CC2);
  static const Color red = Color(0xffFF0000);
  static const Color grey = Color(0xff7D7D7D);
  static const Color grey200 = Colors.grey;
  static const Color lightGrey = Color(0xffC9C9C9);
  static const Color creditGreen = Color(0xff34C759);
  static const Color debitOrange = Color(0xffEB4200);
  static const Color eyeWhite = Color(0xffF2F2F7);
  static const Color dipBlack = Color(0xff4B4B4B);
  static const Color rayBrown = Color(0xffD9D9D9);
  static const Color brownGrey = Color(0xffF3F3F3);
  static const Color blackIdle = Color(0xff292D32);
  static const Color warpGreen = Color(0xff008000);
  static const Color eddyBrown = Color(0xffE5E5E5);
  static const Color fafaWhite = Color(0xffFAFAFA);
  static const Color limitBg = Color(0xffFFD4B8);

  static const lightBlue = Color(0xFF2978D6);
  static const darkBlue100 = Color(0xFF334F98);
  static const sheetLightBlue = Color(0xFF8AD0EF);
  static const numPad = Color(0xFFECEFF9);
  static const numPad2 = Color(0xFFE8F6FC);

  static const primaryLightBlue = Color(0xFFD8E4FF);
  static const gray700 = Color(0xFF4F4D55);
  static const gray800 = Color(0xFF3D3D3D);
  static const gray600 = Color(0xFF757680);
  static const gray500 = Color(0xFF8D91A0);
  static const gray200 = Color(0xFFEEEDF4);
  static const gray300 = Color(0xFFF8F8F8);
  static const gray100 = Color(0xFFFBF8FD);
  static const gray000 = Color(0xFFC6C6CF);
  static const baseGray = Color(0xFFE7EAF0);

  //Shimmer
  static final shimmerBaseColor = Colors.grey[300]!;
  static const shimmerHighlightColor = Colors.white;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.2,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
}
