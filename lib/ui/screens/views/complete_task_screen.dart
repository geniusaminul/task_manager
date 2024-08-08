import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/controller/completed_task_controller.dart';

import '../../widget/task_item.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<CompletedTaskController>().completeTaskItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: GetBuilder<CompletedTaskController>(
            builder: (completedTaskController) {
          return Visibility(
            visible: Get.find<CompletedTaskController>().completedInProgress ==
                false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              itemCount:
                  Get.find<CompletedTaskController>().completeTaskList.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskListModel: Get.find<CompletedTaskController>()
                      .completeTaskList[index],
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
