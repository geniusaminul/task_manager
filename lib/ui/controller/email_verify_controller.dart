import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/screens/auth/pin_verify_screen.dart';
import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';


class EmailVerifyController extends GetxController {
  bool _emailVerifyInProgress = false;
  bool get emailVerifyInProgress => _emailVerifyInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> emailVerify(String email) async {
    bool isSuccess = false;
    _emailVerifyInProgress = true;
    update();
    String userEmail = email;
    final NetworkResponse response =
    await NetworkCaller.getRequest(Urls.emailVerify(userEmail));
    if (response.isSuccess) {
       Get.to(() => PinVerifyScreen(userEmail: userEmail));
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Login failed! Try again';
    }
    _emailVerifyInProgress = false;
    update();
    return isSuccess;
  }
}
