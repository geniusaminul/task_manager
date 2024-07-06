import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_assignment/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_assignment/ui/widget/background_widget.dart';
import 'package:task_manager_assignment/ui/widget/center_circular_progress_indicator.dart';

import '../../../data/model/network_response.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../utilities/app_colors.dart';
import '../../widget/snack_bar_message.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen(
      {super.key, required this.userEmail, required this.otp});

  final String userEmail;
  final String otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _setPasswordInProgress = false;

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
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Minimum length password 8 character with Latter and number combination',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _confirmPassTEController,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter confirm Password';
                        }
                        if(_passwordTEController.text != _confirmPassTEController.text){
                          return "Password didn't match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: _setPasswordInProgress == false,
                      replacement: circularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              _resetPassword();
                            }
                          },
                          child: const Text('Confirm')),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    _signInSection()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInSection() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  text: "Don't have account",
                  style: const TextStyle(
                      color: AppColors.textColor, fontWeight: FontWeight.w600),
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = _backSignInScreen,
                    text: " Sign in",
                    style: const TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w600))
              ]))
        ],
      ),
    );
  }

  void _backSignInScreen() {
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false,
      );
    }
  }

  Future<void> _resetPassword() async {
    _setPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestData = {
      "email": widget.userEmail,
      "OTP": widget.otp,
      "password": _confirmPassTEController.text
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.resetPassword, body: requestData);
    _setPasswordInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Password Reset!');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Password Reset Failed! Try again');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _confirmPassTEController.dispose();
    _passwordTEController.dispose();
  }
}
