
import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';


class AddNewTaskController extends GetxController {
  bool _createdNewTaskInProgress = false;
  bool get createdNewTaskInProgress => _createdNewTaskInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> addNewTask(String title, String description) async {
    bool isSuccess = false;
    _createdNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestData = {"title": title, "description": description, "status":"New"};
    final NetworkResponse response = await NetworkCaller.postRequest(Urls.createTask, body: requestData);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Add New Task failed! Try again';
    }
    _createdNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}
