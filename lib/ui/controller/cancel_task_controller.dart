import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model_wrapper.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class CancelTaskController extends GetxController {
  bool _cancelInProgress = false;
  bool get cancelInProgress => _cancelInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TaskListModel> _cancelTaskList = [];
  List<TaskListModel> get cancelTaskList => _cancelTaskList;

  Future<bool>cancelTaskItemList() async {
    bool isSuccess = false;
    _cancelInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.cancelTask);
    if (response.isSuccess) {
      TaskModelWrapper taskModelWrapper =
          TaskModelWrapper.fromJson(response.responseData);
      _cancelTaskList = taskModelWrapper.taskListModel ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Get Cancel Task Failed! try again';
    }
    _cancelInProgress = false;
    update();
    return isSuccess;
  }
}
