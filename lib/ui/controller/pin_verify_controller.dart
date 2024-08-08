import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/screens/auth/set_password_screen.dart';
import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';


class PinVerifyController extends GetxController {
  bool _pinVerifyInProgress = false;
  bool get pinVerifyInProgress => _pinVerifyInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> pinVerify(String otp, String email) async {
    bool isSuccess = false;
    _pinVerifyInProgress = true;
    update();
    String oTP = otp;
    String userEmail = email;
    NetworkResponse response = await NetworkCaller.getRequest(Urls.recoverOtp(userEmail, oTP));
    if (response.isSuccess) {
       Get.to(() => SetPasswordScreen(userEmail: userEmail, otp: oTP,));
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Pin Verify failed! Try again';
    }
    _pinVerifyInProgress = false;
    update();
    return isSuccess;
  }
}
