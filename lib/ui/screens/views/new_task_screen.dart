import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_manager_assignment/data/model/network_response.dart';
import 'package:task_manager_assignment/data/model/task_model_wrapper.dart';
import 'package:task_manager_assignment/data/model/task_status_count_model.dart';
import 'package:task_manager_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_assignment/ui/screens/views/add_new_task_screen.dart';
import 'package:task_manager_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_assignment/ui/widget/snack_bar_message.dart';

import '../../../data/model/task_list_model.dart';
import '../../../data/model/task_status_count_wrapper.dart';
import '../../../data/utilities/urls.dart';
import '../../widget/task_item.dart';
import '../../widget/task_summary.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskListModel> taskList = [];
  List<TaskStatusCountModel> taskStatusList = [];
  bool _newTaskListInProgress = false;
  bool _taskStatusCountInProgress = false;
  @override
  void initState() {
    super.initState();
    _newTaskList();
    _taskStatusCount();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          _newTaskList();
          _taskStatusCount();
        },
        child: Column(
          children: [
            _buildTaskSummarySection(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Visibility(
                  visible: _newTaskListInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator(),),
                  child: ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(taskListModel: taskList[index]);

                    },
                  ),
                )
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: _moveAddNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildTaskSummarySection() {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      child: Visibility(
        visible: _taskStatusCountInProgress == false,
        replacement: const Center(child: CircularProgressIndicator(),),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: taskStatusList.map(
                (e){
                  return  TaskSummary(count: e.sum.toString(), title: e.sId.toString());
                }
            ).toList()

          ),
        ),
      ),
    );
  }

  void _moveAddNewTask() {
    if(mounted){
      Navigator.push(context, MaterialPageRoute(builder:  (context) => const AddNewTaskScreen(),),);
    }
  }
  Future<void> _taskStatusCount() async{
    _taskStatusCountInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.taskStatusCount);
    if(response.isSuccess){
      TaskStatusCountWrapper taskStatusCountWrapper = TaskStatusCountWrapper.fromJson(response.responseData);
      taskStatusList = taskStatusCountWrapper.taskStatusCountModel ?? [];
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Get Status Count Failed! try again');
      }
    }
    _taskStatusCountInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }
  Future<void> _newTaskList() async{
    _newTaskListInProgress = true;
    if(mounted){
      setState(() {

      });
    }
   NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);
    if(response.isSuccess){
      TaskModelWrapper taskModelWrapper = TaskModelWrapper.fromJson(response.responseData);
      taskList = taskModelWrapper.taskListModel ?? [];
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Get New Task Failed! try again');
      }
    }
    _newTaskListInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }
}


