import 'package:alive_app/core/constants/colors.dart';
import 'package:flutter/material.dart';


class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
    ),

    iconTheme: const IconThemeData(
      color: AppColors.black,
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.black),
    ),
  );
}