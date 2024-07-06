import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_assignment/ui/screens/auth/pin_verify_screen.dart';
import 'package:task_manager_assignment/ui/utilities/app_constant.dart';
import 'package:task_manager_assignment/ui/widget/background_widget.dart';
import 'package:task_manager_assignment/ui/widget/center_circular_progress_indicator.dart';

import '../../../data/model/network_response.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../utilities/app_colors.dart';
import '../../widget/snack_bar_message.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _emailVerifyInProgress = false;

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
                      'Your Email Address',
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
                        if(AppConstant.regExp.hasMatch(value!) == false){
                          return 'Enter valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: _emailVerifyInProgress == false,
                      replacement: circularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              _emailVerify();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
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
      Navigator.pop(context);
    }
  }

  Future<void> _emailVerify() async{
    _emailVerifyInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    String userEmail = _emailTEController.text.trim();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.emailVerify(userEmail));
    if(response.isSuccess){
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVerifyScreen(userEmail: userEmail,),
          ),
        );
      }
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Email verify Failed! try again');
      }
    }
    _emailVerifyInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
