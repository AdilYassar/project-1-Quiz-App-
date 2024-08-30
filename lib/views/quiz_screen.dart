import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/question_controller.dart';
import 'package:flutter_application_1/views/body.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuestionController questionController = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: questionController.nextQuestion,
              child: const Text("skip"))
        ],
      ),
      body: Body(),
    );
  }
}
