import 'package:get/get.dart';

import '../../data/model/login_model.dart';
import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _signInProgress = false;
  bool get signInProgress => _signInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _signInProgress = true;
    update();
    Map<String, dynamic> requestData = {"email": email, "password": password};
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, body: requestData);
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Login failed! Try again';
    }
    _signInProgress = false;
    update();
    return isSuccess;
  }
}
