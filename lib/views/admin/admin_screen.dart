import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/question_controller.dart';
import 'package:flutter_application_1/models/questions_model.dart';
import 'package:get/get.dart';

class AdminScreen extends StatelessWidget {
  final String quizCategory;

  AdminScreen({super.key, required this.quizCategory});
  final QuestionController questionController = Get.find<QuestionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category: $quizCategory"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: questionController.questionControllerText,
                decoration: const InputDecoration(labelText: "Question"),
              ),
              for (var i = 0; i < 4; i++)
                TextFormField(
                  controller: questionController.optionControllers[i],
                  decoration: InputDecoration(labelText: "Option ${i + 1}"),
                ),
              TextFormField(
                controller: questionController.correctAnswerController,
                decoration: const InputDecoration(labelText: "Correct answer"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (questionController.questionControllerText.text.isEmpty ||
                      questionController.optionControllers
                          .any((controller) => controller.text.isEmpty) ||
                      questionController.correctAnswerController.text.isEmpty) {
                    Get.snackbar("Required", "All fields need to be filled");
                  } else {
                    addQuestions();
                  }
                },
                child: const Text("Add question"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addQuestions() async {
    final String questionText = questionController.questionControllerText.text;
    final List<String> options = questionController.optionControllers
        .map((controller) => controller.text)
        .toList();
    final int correctAnswer =
        int.tryParse(questionController.correctAnswerController.text) ?? 1;

    final Question newQuestion = Question(
      category: quizCategory,
      id: DateTime.now().microsecondsSinceEpoch,
      questions: questionText,
      options: options,
      answer: correctAnswer,
    );

    await questionController.saveQuestionToSharedPreferences(newQuestion);

    Get.snackbar("Success", "Question added successfully");

    questionController.questionControllerText.clear();
    questionController.optionControllers
        .forEach((controller) => controller.clear());
    questionController.correctAnswerController.clear();
  }
}
