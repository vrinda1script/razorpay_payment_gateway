import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/constants/app_colors.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.appWhiteColor,
        ),
        primaryColor: AppColors.appTextColor,
        canvasColor: AppColors.appWhiteColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: "Inter",
            color: AppColors.appTextColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontFamily: "Inter",
            color: AppColors.appTextColor,
            fontSize: 20,
          ),
          displaySmall: TextStyle(
            fontFamily: "Inter",
            color: AppColors.appTextColor,
            fontSize: 18,
          ),
          headlineLarge: TextStyle(
            fontFamily: "Inter",
            color: AppColors.appTextColor,
            fontSize: 16,
          ),
          headlineMedium: TextStyle(
            fontFamily: "Inter",
            color: AppColors.appTextColor,
            fontSize: 14,
          ),
          headlineSmall: TextStyle(
            fontFamily: "Inter",
            color: AppColors.appTextColor,
            fontSize: 12,
          ),
          titleSmall: TextStyle(
            fontFamily: "Inter",
            color: AppColors.appTextColor,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
