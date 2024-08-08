
import 'package:get/get.dart';
import 'package:task_manager_assignment/data/model/task_list_model.dart';
import '../../data/model/network_response.dart';
import '../../data/model/task_model_wrapper.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class NewTaskController extends GetxController{

  bool _newTaskListInProgress = false;
  bool get newTaskListInProgress => _newTaskListInProgress;
  List<TaskListModel> _taskList = [];
  List <TaskListModel> get newTaskList => _taskList;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> newTaskItemList() async {

    bool isSuccess = false;
    _newTaskListInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);
    if (response.isSuccess) {
      TaskModelWrapper taskModelWrapper =
      TaskModelWrapper.fromJson(response.responseData);
      _taskList = taskModelWrapper.taskListModel ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Get New Task Failed!';
    }
    _newTaskListInProgress = false;
    update();
    return isSuccess;
  }
}