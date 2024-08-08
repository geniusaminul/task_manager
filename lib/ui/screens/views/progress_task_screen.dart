import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/controller/progress_task_controller.dart';

import '../../widget/task_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<ProgressTaskController>().progressTaskItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: GetBuilder<ProgressTaskController>(
            builder: (progressTaskController) {
          return Visibility(
            visible:
                Get.find<ProgressTaskController>().progressTaskInProgress ==
                    false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              itemCount:
                  Get.find<ProgressTaskController>().progressTaskList.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskListModel: Get.find<ProgressTaskController>()
                      .progressTaskList[index],
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
