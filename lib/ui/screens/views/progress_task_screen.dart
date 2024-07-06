import 'package:flutter/material.dart';

import '../../../data/model/network_response.dart';
import '../../../data/model/task_list_model.dart';
import '../../../data/model/task_model_wrapper.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../widget/snack_bar_message.dart';
import '../../widget/task_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _progressTaskInProgress = false;
  List<TaskListModel> progressTaskList = [];

  @override
  void initState() {
    super.initState();
    _progressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Visibility(
          visible: _progressTaskInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: progressTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskListModel: progressTaskList[index],
                onUpdateTask: () {
                  _progressTaskList();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _progressTaskList() async {
    _progressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.progressTask);
    if (response.isSuccess) {
      TaskModelWrapper taskModelWrapper =
          TaskModelWrapper.fromJson(response.responseData);
      progressTaskList = taskModelWrapper.taskListModel ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Get New Task Failed! try again');
      }
    }
    _progressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
