import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_assignment/data/model/network_response.dart';
import 'package:task_manager_assignment/data/model/user_model.dart';
import 'package:task_manager_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_assignment/ui/controller/auth_controller.dart';
import 'package:task_manager_assignment/ui/utilities/app_constant.dart';
import 'package:task_manager_assignment/ui/widget/background_widget.dart';
import 'package:task_manager_assignment/ui/widget/center_circular_progress_indicator.dart';
import 'package:task_manager_assignment/ui/widget/profile_app_bar.dart';
import 'package:task_manager_assignment/ui/widget/snack_bar_message.dart';

import '../../../data/utilities/urls.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fNameTEController = TextEditingController();
  final TextEditingController _lNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _profileUpdateInProgress = false;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    final userData = AuthController.userModel;
    _emailTEController.text = userData?.email ?? '';
    _fNameTEController.text = userData?.firstName ?? '';
    _lNameTEController.text = userData?.lastName ?? '';
    _mobileTEController.text = userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
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
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    imagePickerSection(),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      enabled: false,
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

                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: _profileUpdateInProgress == false,
                      replacement: circularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              _updateProfile();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePickerSection() {
    return GestureDetector(
      onTap: _profileImagePicker,
      child: Container(
        width: double.maxFinite,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 48,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: Colors.black38),
              child: const Text(
                'Photo',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              _selectedImage?.name ?? 'No image select',
              maxLines: 1,
            ))
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _profileUpdateInProgress = true;
    String? encodePhoto = AuthController.userModel?.photo;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestData = {
      "email": _emailTEController.text.trim(),
      "firstName": _fNameTEController.text.trim(),
      "lastName": _lNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestData['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);
      encodePhoto = base64Encode(file.readAsBytesSync());
      requestData['photo'] = encodePhoto;
    }
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.profileUpdate, body: requestData);
    _profileUpdateInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userModel = UserModel(
          photo: encodePhoto,
          firstName: _fNameTEController.text.trim(),
          lastName: _lNameTEController.text.trim(),
          mobile: _mobileTEController.text.trim(),
          email: _emailTEController.text);
      await AuthController.saveUserData(userModel);
      if (mounted) {
        showSnackBarMessage(context, 'Profile Updated!');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Profile Updated Failed! Try again');
      }
    }
  }

  Future<void> _profileImagePicker() async {
    final imagePicker = ImagePicker();
    final XFile? result =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (result != null) {
      _selectedImage = result;
      if (mounted) {
        setState(() {});
      }
    }
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
