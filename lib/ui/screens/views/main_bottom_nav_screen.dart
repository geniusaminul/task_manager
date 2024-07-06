import 'package:flutter/material.dart';
import 'package:task_manager_assignment/ui/screens/views/canceled_task_screen.dart';
import 'package:task_manager_assignment/ui/screens/views/complete_task_screen.dart';
import 'package:task_manager_assignment/ui/screens/views/new_task_screen.dart';
import 'package:task_manager_assignment/ui/screens/views/progress_task_screen.dart';

import '../../utilities/app_colors.dart';
import '../../widget/profile_app_bar.dart';
class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
int _selectIndex = 0;
final List<Widget> _screens = const [
  NewTaskScreen(),
  CompleteTaskScreen(),
  ProgressTaskScreen(),
  CanceledTaskScreen()

];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
      body: _screens[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: AppColors.textColor,
        showUnselectedLabels: true,
        currentIndex: _selectIndex,
        onTap: (index) {
          _selectIndex = index;
          if(mounted){
            setState(() {

            });
          }

        },




        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New Task'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Complete'),
          BottomNavigationBarItem(icon: Icon(Icons.timelapse_outlined), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
        ],

      ),
    );
  }


}
