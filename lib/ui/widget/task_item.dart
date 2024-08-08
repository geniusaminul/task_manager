import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager_assignment/data/model/task_list_model.dart';
import 'package:task_manager_assignment/ui/controller/delete_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/update_task_controller.dart';
import 'package:task_manager_assignment/ui/widget/center_circular_progress_indicator.dart';
import 'package:task_manager_assignment/ui/widget/snack_bar_message.dart';

import '../utilities/app_colors.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskListModel,
    required this.onUpdateTask,
  });

  final TaskListModel taskListModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {

  String dropdownValue = '';
  List<String> statusList = ['New', 'Completed', 'Progress', 'Cancel'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.taskListModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: ListTile(
        title: Text(widget.taskListModel.title ?? 'Unknown',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskListModel.description ?? ''),
            Text('Date : ${widget.taskListModel.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.taskListModel.status ?? 'New',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  backgroundColor: (widget.taskListModel.status == 'Completed')
                      ? AppColors.completeTaskColor
                      : (widget.taskListModel.status == 'Progress')
                          ? AppColors.progressTaskColor
                          : (widget.taskListModel.status == 'Cancel')
                              ? AppColors.cancelTaskColor
                              : AppColors.newTaskColor,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                ),
                ButtonBar(
                  children: [
                    Visibility(
                      visible: Get.find<UpdateTaskController>().updateTaskInProgress == false,
                      replacement: circularProgressIndicator(),
                      child: PopupMenuButton(
                          icon: const Icon(Icons.edit, color:AppColors.themeColor ,),
                          onSelected: (String selectedValue) {
                            dropdownValue = selectedValue;
                            _updateTask(dropdownValue);
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return statusList.map((String value) {
                              return PopupMenuItem<String>(
                                  value: value,
                                  child: ListTile(
                                    title: Text(value),
                                    trailing: dropdownValue == value
                                        ? const Icon(Icons.done)
                                        : null,
                                  ));
                            }).toList();
                          }),
                    ),
                    Visibility(
                      visible: Get.find<DeleteTaskController>().deleteTaskInProgress == false,
                      replacement: circularProgressIndicator(),
                      child: IconButton(
                          onPressed: _deleteTask,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red.shade400,
                          )),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateTask(String value) async {
  final UpdateTaskController controller = Get.find<UpdateTaskController>();
  bool result = await controller.updateTask(value, widget.taskListModel.sId!);

    if (result) {
      if (mounted) {
        showSnackBarMessage(context, 'Update Task Success!');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, 'Update Task Failed! try again');
      }
    }
  }

  Future<void> _deleteTask() async {
  final DeleteTaskController controller = Get.find<DeleteTaskController>();
  bool result = await controller.deleteTask(widget.taskListModel.sId!);

    if (result) {
      if (mounted) {
        showSnackBarMessage(context, 'Delete Task Success!');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, 'Delete Task Failed! try again');
      }
    }

  }
}
