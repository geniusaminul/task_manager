import 'package:flutter/material.dart';
import 'package:task_manager_assignment/ui/screens/auth/splash_screen.dart';
import 'package:task_manager_assignment/ui/utilities/app_colors.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      title: 'TaskManager',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.themeColor),
            ),
            filled: true,
            fillColor: Colors.white,
            hintStyle:
                TextStyle(fontSize: 16, color: AppColors.placeholderColor),
          ),
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              titleSmall: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.textColor)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.maxFinite),
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 13)))),
    );
  }
}
