import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';


class SetPasswordController extends GetxController {
  bool _setPasswordInProgress = false;
  bool get setPasswordInProgress => _setPasswordInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> setPassword(String userEmail, String password, String otp) async {
    bool isSuccess = false;
    _setPasswordInProgress = true;
    update();
    Map<String, dynamic> requestData = {"email": userEmail  , "password": password, "OTP": otp};
    final NetworkResponse response =
    await NetworkCaller.postRequest(Urls.resetPassword, body: requestData);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Password Set failed! Try again';
    }
    _setPasswordInProgress = false;
    update();
    return isSuccess;
  }
}
