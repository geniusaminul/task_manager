import 'package:task_manager_assignment/data/model/task_list_model.dart';

class TaskModelWrapper {
  String? status;
  List<TaskListModel>? taskListModel;

  TaskModelWrapper({this.status, this.taskListModel});

  TaskModelWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskListModel = <TaskListModel>[];
      json['data'].forEach((v) {
        taskListModel!.add(TaskListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskListModel != null) {
      data['data'] = taskListModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


