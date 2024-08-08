import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model_wrapper.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class ProgressTaskController extends GetxController {
  bool _progressTaskInProgress = false;
  bool get progressTaskInProgress => _progressTaskInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TaskListModel> _progressTaskList = [];
  List<TaskListModel> get progressTaskList => _progressTaskList;

  Future<bool> progressTaskItemList() async {
    bool isSuccess = false;
    _progressTaskInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.progressTask);
    if (response.isSuccess) {
      TaskModelWrapper taskModelWrapper =
          TaskModelWrapper.fromJson(response.responseData);
      _progressTaskList = taskModelWrapper.taskListModel ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Get Progress Task Failed! try again';
    }
    _progressTaskInProgress = false;
    update();
    return isSuccess;
  }
}
