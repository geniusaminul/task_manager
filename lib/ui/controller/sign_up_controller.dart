import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class SignUpController extends GetxController {
  bool _signUpProgress = false;

  bool get signUpProgress => _signUpProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> signUp(String email, String firstName, String lastName,
      String mobile, String password) async {
    bool isSuccess = false;
    _signUpProgress = true;
    update();
    Map<String, dynamic> requestData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.signUp, body: requestData);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Sign Up failed! Try again';
    }
    _signUpProgress = false;
    update();
    return isSuccess;
  }
}
