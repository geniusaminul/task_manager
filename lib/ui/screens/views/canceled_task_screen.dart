import 'package:flutter/material.dart';
import 'package:task_manager_assignment/ui/widget/task_item.dart';

import '../../../data/model/network_response.dart';
import '../../../data/model/task_list_model.dart';
import '../../../data/model/task_model_wrapper.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../widget/snack_bar_message.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _cancelInProgress = false;
  List<TaskListModel> cancelTaskList = [];
  @override
  void initState() {
    super.initState();
    _cancelTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Visibility(
          visible: _cancelInProgress == false,
          replacement: const Center(child: CircularProgressIndicator(),),
          child: ListView.builder(
            itemCount: cancelTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(taskListModel: cancelTaskList[index], onUpdateTask: () {
                _cancelTaskList();
              },);
            },
          ),
        ),
      ),

    );
  }
  Future<void> _cancelTaskList() async{
    _cancelInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelTask);
    if(response.isSuccess){
      TaskModelWrapper taskModelWrapper = TaskModelWrapper.fromJson(response.responseData);
      cancelTaskList = taskModelWrapper.taskListModel ?? [];
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Get Cancel Task Failed! try again');
      }
    }
    _cancelInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }
}
