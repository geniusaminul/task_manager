import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/controller/new_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/task_status_count_controller.dart';
import 'package:task_manager_assignment/ui/screens/views/add_new_task_screen.dart';
import 'package:task_manager_assignment/ui/utilities/app_colors.dart';
import '../../widget/task_item.dart';
import '../../widget/task_summary.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<TaskStatusCountController>().taskStatusCount();
    Get.find<NewTaskController>().newTaskItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _initialCall();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTaskSummarySection(),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: GetBuilder<NewTaskController>(
                      builder: (newTaskController) {
                        return Visibility(
                          visible:
                          Get.find<NewTaskController>().newTaskListInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ListView.builder(
                            itemCount: Get.find<NewTaskController>().newTaskList.length,
                            itemBuilder: (context, index) {
                              return TaskItem(
                                taskListModel: Get.find<NewTaskController>().newTaskList[index],
                                onUpdateTask: _initialCall,

                              );
                            },
                          ),
                        );
                      })),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      child: GetBuilder<TaskStatusCountController>(
          builder: (taskStatusCountController) {
            return Visibility(
              visible: Get.find<TaskStatusCountController>().taskStatusCountInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: Get.find<TaskStatusCountController>().taskStatusList.map((e) {
                      return TaskSummary(
                          count: e.sum.toString(),
                          title: e.sId ?? 'Unknown'.toUpperCase());
                    }).toList()),
              ),
            );
          }),
    );
  }

  void _moveAddNewTask() {
    Get.to( const AddNewTaskScreen());
  }
}
