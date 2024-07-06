
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_assignment/app.dart';
import 'package:task_manager_assignment/ui/controller/auth_controller.dart';

import '../screens/views/update_profile_screen.dart';


AppBar profileAppBar() {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: MemoryImage(
                    base64Decode(AuthController.userModel?.photo ?? '')),
                fit: BoxFit.fill,
              )),
        ),
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap:  () async{
                Navigator.push(
                  TaskManager.navigatorKey.currentContext!,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProfileScreen(),
                  ),
                );


          } ,
            child: Text(
          AuthController.userModel!.fullName,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        )),
        Text(
          AuthController.userModel?.email ?? '',
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
        )
      ],
    ),
    actions: [
      IconButton(
          onPressed: () async{
            AuthController.redirectToLogin();
          },
          icon: const Icon(Icons.logout))
    ],
  );

}
