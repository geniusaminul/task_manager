import 'package:task_manager_assignment/data/model/task_status_count_model.dart';

class TaskStatusCountWrapper {
  String? status;
  List<TaskStatusCountModel>? taskStatusCountModel;

  TaskStatusCountWrapper({this.status, this.taskStatusCountModel});

  TaskStatusCountWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusCountModel = <TaskStatusCountModel>[];
      json['data'].forEach((v) {
        taskStatusCountModel!.add(TaskStatusCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskStatusCountModel != null) {
      data['data'] = taskStatusCountModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}