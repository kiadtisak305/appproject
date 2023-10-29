class AppConstants {
  static AppConstants? _instance;
  static AppConstants get instance {
    _instance ??= AppConstants._init();
    return _instance!;
  }

  AppConstants._init();

  // Core
  final String appName = "Fit Track";
  final String fontFamily = "Moderat";
  final String error = "Something went wrong!";
  final String formValidation = "Required field.";

  // Login
  final String loginHello = "Hi, Welcome Back";
  final String loginTitle = "Login into your account";
  final String yourEmail = "Your Email";
  final String yourPassword = "Your Password";
  final String signUp = "Sign Up";
  final String signIn = "Sign In";

  // Register
  final String createAccountTitle = "Create an Account";
  final String yourName = "Your Name";
  final String email = "E-mail";
  final String password = "Password";
  final String createAccountButton = "Create Account";
  final String haveAnAccount = "Already have an account?";

  // Home
  final String daysTitle = "Days";
  final String hello = "Hello";
  final String chooseDayTitle = "Choose the day you want to make reservations.";

  // Workouts
  final String workouts = "Workouts";
  final String selectForChange = "Select the workout you want to change";
  final String emptyPlan = "You have not planned any training.";

  // Add Workout
  final String trainingAddTitle = "Training Add";
  final String addWorkoutChoice = "Add the workout of your choice.";
  final String trainingName = "Training Name";
  final String trainingTime = "Training Time";
  final String add = "Add";

  // Update Workout
  final String dontForgetUpdate =
      "After changing the program, don't forget\nto update it.";
  final String update = "Update";

  // Snackbar
  final String titlesucceed = "Succeed";
  final String titleerror = "Error: ";
  final String loginsucceed = "เข้าสู่ระบบสำเร็จ";
  final String passvaridate = "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
  final String passvaridatefail = "รหัสผ่านไม่ถูกต้อง";
  final String registersucceed = "ลงทะเบียนสำเร็จ";
  final String emailvaridatefail = "มีอีเมลนี้ในระบบแล้ว โปรดใช้อีเมลอื่นแทน";
  final String varidatefail = "";
}
