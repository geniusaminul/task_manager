import 'package:get/get.dart';
import 'package:task_manager_assignment/data/model/task_list_model.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';


class UpdateTaskController extends GetxController{
  bool _updateTaskInProgress = false;
  bool get updateTaskInProgress => _updateTaskInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  final List <TaskListModel> _taskListModel = [];
  List <TaskListModel> get taskListModel => _taskListModel;


  Future<bool> updateTask(String value,  String sId) async {
    bool isSuccess = false;
    _updateTaskInProgress = true;
   update();
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.updateTask( sId, value));

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Update Task Failed! Try again';
    }
    _updateTaskInProgress = false;
    update();
    return isSuccess;
  }

}