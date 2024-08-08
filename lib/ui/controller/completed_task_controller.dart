import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model_wrapper.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class CompletedTaskController extends GetxController {
  bool _completedInProgress = false;
  bool get completedInProgress => _completedInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TaskListModel> _completeTaskList = [];
  List<TaskListModel> get completeTaskList => _completeTaskList;

  Future<bool> completeTaskItemList() async {
    bool isSuccess = false;
    _completedInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTask);
    if (response.isSuccess) {
      TaskModelWrapper taskModelWrapper =
      TaskModelWrapper.fromJson(response.responseData);
      _completeTaskList = taskModelWrapper.taskListModel ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Get Completed Task Failed! try again';
    }
    _completedInProgress = false;
    update();
    return isSuccess;
  }
}
