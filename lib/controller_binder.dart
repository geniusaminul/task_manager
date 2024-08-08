import 'package:get/get.dart';
import 'package:task_manager_assignment/ui/controller/add_new_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/cancel_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/completed_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/delete_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/email_verify_controller.dart';
import 'package:task_manager_assignment/ui/controller/new_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/pin_verify_controller.dart';
import 'package:task_manager_assignment/ui/controller/progress_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/set_password_controller.dart';
import 'package:task_manager_assignment/ui/controller/sign_in_controller.dart';
import 'package:task_manager_assignment/ui/controller/sign_up_controller.dart';
import 'package:task_manager_assignment/ui/controller/task_status_count_controller.dart';
import 'package:task_manager_assignment/ui/controller/update_profile_task_controller.dart';
import 'package:task_manager_assignment/ui/controller/update_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => TaskStatusCountController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => CancelTaskController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => UpdateProfileTaskController());
    Get.lazyPut(() => EmailVerifyController());
    Get.lazyPut(() => PinVerifyController());
    Get.lazyPut(() => SetPasswordController());
    Get.lazyPut(() => UpdateTaskController());
    Get.lazyPut(() => DeleteTaskController());

  }
}