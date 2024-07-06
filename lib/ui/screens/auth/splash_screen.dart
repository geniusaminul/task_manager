import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_assignment/ui/controller/auth_controller.dart';
import 'package:task_manager_assignment/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_assignment/ui/screens/views/main_bottom_nav_screen.dart';
import 'package:task_manager_assignment/ui/widget/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveSignInScreen();

  }

  Future<void> _moveSignInScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isUserLoggedIn = await AuthController.checkAuthState();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isUserLoggedIn ? const MainBottomNavScreen() : const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
      child: Center(
          child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 140,
      )),
    ));
  }
}
