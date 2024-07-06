import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_assignment/data/model/network_response.dart';
import 'package:task_manager_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_assignment/ui/screens/auth/email_verify_screen.dart';
import 'package:task_manager_assignment/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager_assignment/ui/screens/views/main_bottom_nav_screen.dart';
import 'package:task_manager_assignment/ui/widget/background_widget.dart';
import 'package:task_manager_assignment/ui/widget/profile_app_bar.dart';
import 'package:task_manager_assignment/ui/widget/snack_bar_message.dart';

import '../../../data/utilities/urls.dart';
import '../../utilities/app_colors.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _createdNewTaskInProgress = false;


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
                    Visibility(
                      visible: _createdNewTaskInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                             _createNewTask();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
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

Future<void> _createNewTask() async{
    _createdNewTaskInProgress = true;
    if(mounted){
      setState(() {
        
      });
    }
    Map<String, dynamic> requestData ={
      "title":_titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status":"New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(Urls.createTask, body: requestData);
    _createdNewTaskInProgress = false;
    if(mounted){
      setState(() {

      });
    }
    if(response.isSuccess){
      if(mounted){
        showSnackBarMessage(context, 'Added New Task!');
      }
    } else{
      if(mounted){
        showSnackBarMessage(context, 'Added New Task Failed! try again');
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
