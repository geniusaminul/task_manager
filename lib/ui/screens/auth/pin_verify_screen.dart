import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_assignment/ui/screens/auth/set_password_screen.dart';
import 'package:task_manager_assignment/ui/screens/auth/sign_in_screen.dart';

import 'package:task_manager_assignment/ui/widget/background_widget.dart';
import 'package:task_manager_assignment/ui/widget/center_circular_progress_indicator.dart';

import '../../../data/model/network_response.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../utilities/app_colors.dart';
import '../../widget/snack_bar_message.dart';

class PinVerifyScreen extends StatefulWidget {
  const PinVerifyScreen({super.key, required this.userEmail});
  final String userEmail;


  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _pinVerifyInProgress = false;

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
                      'Pin Verification',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'A 6 digit verification pin will send to your email address',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _pinFieldSection(context),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: _pinVerifyInProgress == false,
                      replacement: circularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              _recoverOtp();
                            }
                          },
                          child: const Text('Verify')),
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

  Widget _pinFieldSection(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      controller: _pinTEController,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(4),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          selectedColor: AppColors.themeColor,
          inactiveFillColor: Colors.white,
          inactiveColor: AppColors.placeholderColor),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      appContext: context,
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

  Future<void> _recoverOtp() async{
    _pinVerifyInProgress = true;
    if(mounted){
      setState(() {

      });
    }
     String otp = _pinTEController.text.trim();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.recoverOtp(widget.userEmail, otp));
    if(response.isSuccess){
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetPasswordScreen(userEmail: widget.userEmail, otp: otp,),
          ),
        );
      }
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Pin verify Failed! try again');
      }
    }
    _pinVerifyInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }
  @override
  void dispose() {
    super.dispose();
    _pinTEController.dispose();
  }
}
