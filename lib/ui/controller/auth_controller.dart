import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_assignment/app.dart';
import 'package:task_manager_assignment/data/model/user_model.dart';
import 'package:task_manager_assignment/ui/screens/auth/sign_in_screen.dart';

class AuthController {
 static const String _accessTokenKey = 'access-token';
 static const String _userDataKey = 'user-data';
 static String accessToken = '';
 static UserModel? userModel;

  static Future<void> saveUserAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserAccessToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_accessTokenKey);
  }
  
  static Future<void> saveUserData(UserModel user) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
    userModel = user;
  }

  static Future<UserModel?> getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_userDataKey);
    if(data == null) return null;
    UserModel userModel = UserModel.fromJson(jsonDecode(data));
    return userModel;
  }

  static Future<bool> checkAuthState() async{
    String? token = await getUserAccessToken();
    if(token == null) return false;
    accessToken = token;
    userModel = await getUserData();
    return true;
  }

  static Future<void> clearUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
  static Future<void> redirectToLogin() async{
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      TaskManager.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (route) => false,
    );
  }
}