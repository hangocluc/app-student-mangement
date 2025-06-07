import 'package:base_bloc_cubit/common/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const String NotoSansJP = "NotoSansJP";
  ThemeData get lightTheme => _lightTheme;
  // static final TextTheme _textTheme = TextTheme(
  //   titleSmall: TextStyle(fontSize: 12.0.sp, fontFamily: NotoSansJP),
  //   titleMedium: TextStyle(fontSize: 13.0.sp, fontFamily: NotoSansJP),
  //   titleLarge: TextStyle(fontSize: 14.0.sp, fontFamily: NotoSansJP),
  //   labelSmall: TextStyle(fontSize: 14.0.sp, fontFamily: NotoSansJP),
  //   labelMedium: TextStyle(fontSize: 15.0.sp, fontFamily: NotoSansJP),
  //   labelLarge: TextStyle(fontSize: 16.0.sp, fontFamily: NotoSansJP),
  // );

  static final _lightTheme = ThemeData(
    primaryColor: AppColors.primary.primary500,
    scaffoldBackgroundColor: AppColors.primary.primary500,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary.primary500),
    appBarTheme: AppBarTheme(
      color: AppColors.primary.primary500,
      iconTheme: IconThemeData(color: AppColors.white.white),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary.primary500,
    ),
    iconTheme: IconThemeData(
      color: AppColors.white.white,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.primary.primary500,
    ),
    // textTheme: _textTheme,
    // Add reorder theme colors.
    canvasColor: AppColors.white.white, // Background when dragging,
    bottomSheetTheme: BottomSheetThemeData(
      dragHandleSize: Size(50.w, 5.w),
      dragHandleColor: AppColors.theBlack.theBlack200,
      elevation: 2,
      modalElevation: 2,
    ),
  );
}
