import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/controller/add_new_task_controller.dart';
import 'package:task_manager_assignment/ui/widget/background_widget.dart';
import 'package:task_manager_assignment/ui/widget/profile_app_bar.dart';
import 'package:task_manager_assignment/ui/widget/snack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
      body: Background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Text(
                      'Add New Task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _titleTEController,
                      decoration: const InputDecoration(
                        hintText: 'Subject',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Write Subject';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Write Description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GetBuilder<AddNewTaskController>(
                        builder: (addNewTaskController) {
                      return Visibility(
                        visible: Get.find<AddNewTaskController>().createdNewTaskInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              _onTapAddNewTask();
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      );
                    }),
                    const SizedBox(
                      height: 26,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapAddNewTask() async {
    if (_globalKey.currentState!.validate()) {
      final AddNewTaskController controller = Get.find<AddNewTaskController>();
      final bool result = await controller.addNewTask(
          _titleTEController.text.trim(), _descriptionTEController.text.trim());
      if (result) {
        if (mounted) {
          showSnackBarMessage(context, 'Added New Task');
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, controller.errorMessage);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}
