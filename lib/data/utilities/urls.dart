class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String signUp = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String newTask = '$_baseUrl/listTaskByStatus/New';
  static const String progressTask = '$_baseUrl/listTaskByStatus/Progress';
  static const String completedTask = '$_baseUrl/listTaskByStatus/Completed';
  static const String cancelTask = '$_baseUrl/listTaskByStatus/Cancel';
  static const String createTask = '$_baseUrl/createTask';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static  String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static  String emailVerify(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static  String recoverOtp(String email, String otp) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static  String profileUpdate = '$_baseUrl/profileUpdate';
  static  String resetPassword = '$_baseUrl/RecoverResetPass';
}