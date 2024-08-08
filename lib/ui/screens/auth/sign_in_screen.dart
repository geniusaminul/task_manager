import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/controller/sign_in_controller.dart';
import 'package:task_manager_assignment/ui/screens/auth/email_verify_screen.dart';
import 'package:task_manager_assignment/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager_assignment/ui/screens/views/main_bottom_nav_screen.dart';
import 'package:task_manager_assignment/ui/utilities/app_constant.dart';
import 'package:task_manager_assignment/ui/widget/background_widget.dart';
import 'package:task_manager_assignment/ui/widget/snack_bar_message.dart';

import '../../utilities/app_colors.dart';
import '../../widget/center_circular_progress_indicator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter email address';
                        }
                        if (AppConstant.regExp.hasMatch(value!) == false) {
                          return 'Enter valid Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: _showPassword == false,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                _showPassword = !_showPassword;
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              icon: Icon(_showPassword
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off))),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GetBuilder<SignInController>(builder: (signInController) {
                      return Visibility(
                        visible: signInController.signInProgress == false,
                        replacement: circularProgressIndicator(),
                        child: ElevatedButton(
                            onPressed: _onTapSignInButton,
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      );
                    }),
                    const SizedBox(
                      height: 26,
                    ),
                    _signUpSection()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpSection() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: _moveEmailVerifyScreen,
              child: const Text('Forget Password')),
          RichText(
              text: TextSpan(
                  text: "Don't have account",
                  style: const TextStyle(
                      color: AppColors.textColor, fontWeight: FontWeight.w600),
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = _moveSignUpScreen,
                    text: " Sign up",
                    style: const TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w600))
              ]))
        ],
      ),
    );
  }

  Future<void> _onTapSignInButton() async {
    if (_globalKey.currentState!.validate()) {
      final SignInController controller = Get.find<SignInController>();
      final bool result = await controller.signIn(
          _emailTEController.text.trim(), _passwordTEController.text);
      if (result) {
        Get.offAll(const MainBottomNavScreen());
      } else {
        if (mounted) {
          showSnackBarMessage(context, controller.errorMessage);
        }
      }
    }
  }

  void _moveSignUpScreen() {
    Get.to( const SignUpScreen());
  }

  void _moveEmailVerifyScreen() {
    Get.to( const EmailVerifyScreen());
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
