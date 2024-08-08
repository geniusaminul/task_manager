import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/network_response.dart';
import '../../data/model/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'auth_controller.dart';

class UpdateProfileTaskController extends GetxController {
  bool _updateProfileTaskInProgress = false;

  bool get updateProfileTaskInProgress => _updateProfileTaskInProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;
  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;

  Future<void> profileImagePicker() async {
    final imagePicker = ImagePicker();
    XFile? result = await imagePicker.pickImage(source: ImageSource.camera);
    if (result != null) {
      _selectedImage = result;
      update();
    }
  }

  Future<bool> updateProfile(
      String email, String firstName, String lastName, String mobile,
      [String? password]) async {
    bool isSuccess = false;
    _updateProfileTaskInProgress = true;
    String? encodePhoto = AuthController.userModel?.photo ?? '';
    update();
    Map<String, dynamic> requestData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password != null && password.isNotEmpty) {
      requestData['password'] = password;
    }
    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);
      encodePhoto = base64Encode(file.readAsBytesSync());
      requestData['photo'] = encodePhoto;
    }
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.profileUpdate, body: requestData);

    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userModel = UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        photo: encodePhoto,
      );
      await AuthController.saveUserData(userModel);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? ' Update failed! Try again';
    }
    _updateProfileTaskInProgress = false;
    update();
    return isSuccess;
  }
}
