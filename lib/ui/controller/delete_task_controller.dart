import 'package:get/get.dart';
import 'package:task_manager_assignment/data/model/task_list_model.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';


class DeleteTaskController extends GetxController{
  bool _deleteTaskInProgress = false;
  bool get deleteTaskInProgress => _deleteTaskInProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  final List <TaskListModel> _taskListModel = [];
  List <TaskListModel> get taskListModel => _taskListModel;


  Future<bool> deleteTask(String sId) async {
    bool isSuccess = false;
    _deleteTaskInProgress = true;
   update();
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.deleteTask(sId));

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Delete Failed! Try again';
    }
    _deleteTaskInProgress = false;
    update();
    return isSuccess;
  }

}