import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Welcome.dart';
import 'package:flutter_application_1/views/admin/admin_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/views/admin/admin_dashboard.dart';
import 'package:flutter_application_1/views/quiz_category.dart';
import 'package:flutter_application_1/controllers/question_controller.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized
  // Initialize GetX dependencies
  Get.put(QuestionController()); // Register the controller here
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () =>
                WelcomeScreen()), // Make sure WelcomeScreen is the initial page
        GetPage(name: '/QuizCategory', page: () => QuizCategory()),
        GetPage(name: '/AdminDashboard', page: () => AdminDashboard()),
        GetPage(
            name: '/AdminScreen', page: () => AdminScreen(quizCategory: '')),
      ],
    );
  }
}
