import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/controller/sign_up_controller.dart';
import 'package:task_manager_assignment/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_assignment/ui/utilities/app_constant.dart';
import 'package:task_manager_assignment/ui/widget/background_widget.dart';
import 'package:task_manager_assignment/ui/widget/snack_bar_message.dart';


import '../../utilities/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fNameTEController = TextEditingController();
  final TextEditingController _lNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
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
                      height: 70,
                    ),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter email address';
                        }
                        if (AppConstant.regExp.hasMatch(value!) == false) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _fNameTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter First Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _lNameTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Last Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Mobile Number';
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                : Icons.visibility_off),
                          )),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: Get.find<SignUpController>().signUpProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                             _onTapSignUp();
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
                  text: "Have account?",
                  style: const TextStyle(
                      color: AppColors.textColor, fontWeight: FontWeight.w600),
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = _onTapSignInScreen,
                    text: " Sign in",
                    style: const TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w600))
              ]))
        ],
      ),
    );
  }



  Future<void> _onTapSignUp() async {
    final SignUpController controller = Get.find<SignUpController>();
    bool result =
        await controller.signUp(_emailTEController.text.trim(), _fNameTEController.text.trim(), _lNameTEController.text.trim(), _mobileTEController.text.trim(), _passwordTEController.text);
    if(result){
      _textFieldClear();
      if(mounted){
        showSnackBarMessage(context, 'Sign Up success!');
      }
    }else{
      if(mounted){
        showSnackBarMessage(context, 'Sign Up failed! Try again');
      }
    }
  }
  void _onTapSignInScreen(){
    Get.back();
  }

  void _textFieldClear() {
    _fNameTEController.clear();
    _lNameTEController.clear();
    _emailTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _mobileTEController.dispose();
    _lNameTEController.dispose();
    _fNameTEController.dispose();
  }
}
