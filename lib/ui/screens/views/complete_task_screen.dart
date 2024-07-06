import 'package:flutter/material.dart';

import '../../../data/model/network_response.dart';
import '../../../data/model/task_list_model.dart';
import '../../../data/model/task_model_wrapper.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../widget/snack_bar_message.dart';
import '../../widget/task_item.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _completedInProgress = false;
  List<TaskListModel> completeTaskList = [];
  @override
  void initState() {
    super.initState();
    _completedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Visibility(
          visible: _completedInProgress == false,
          replacement: const Center(child: CircularProgressIndicator(),),
          child: ListView.builder(
            itemCount: completeTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(taskListModel: completeTaskList[index]);
            },
          ),
        ),
      ),
    );
  }
  Future<void> _completedTaskList() async{
    _completedInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTask);
    if(response.isSuccess){
      TaskModelWrapper taskModelWrapper = TaskModelWrapper.fromJson(response.responseData);
      completeTaskList = taskModelWrapper.taskListModel ?? [];
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Get Cancel Task Failed! try again');
      }
    }
    _completedInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }
}
