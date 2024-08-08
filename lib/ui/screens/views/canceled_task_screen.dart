import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/controller/cancel_task_controller.dart';
import 'package:task_manager_assignment/ui/widget/task_item.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<CancelTaskController>().cancelTaskItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child:
            GetBuilder<CancelTaskController>(builder: (cancelTaskController) {
          return Visibility(
            visible: Get.find<CancelTaskController>().cancelInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              itemCount: Get.find<CancelTaskController>().cancelTaskList.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskListModel:
                      Get.find<CancelTaskController>().cancelTaskList[index],
                  onUpdateTask: _initialCall,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
