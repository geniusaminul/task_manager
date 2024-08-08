import 'package:get/get.dart';
import 'package:task_manager_assignment/data/model/task_status_count_model.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_status_count_wrapper.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class TaskStatusCountController extends GetxController {
  bool _taskStatusCountInProgress = false;
  bool get taskStatusCountInProgress => _taskStatusCountInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TaskStatusCountModel> _taskStatusList = [];
  List<TaskStatusCountModel> get taskStatusList => _taskStatusList;

  Future<bool> taskStatusCount() async {
    bool isSuccess = false;
    _taskStatusCountInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      TaskStatusCountWrapper taskStatusCountWrapper =
          TaskStatusCountWrapper.fromJson(response.responseData);
      _taskStatusList = taskStatusCountWrapper.taskStatusCountModel ?? [];
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ?? 'Get Status Count Failed! try again';
    }

    _taskStatusCountInProgress = false;
    update();
    return isSuccess;
  }
}
