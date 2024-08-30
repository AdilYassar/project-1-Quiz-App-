import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/question_controller.dart';
import 'package:flutter_application_1/views/quiz_screen.dart';
import 'package:get/get.dart';

class QuizCategory extends StatelessWidget {
  QuizCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionController _questionController =
        Get.find<QuestionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Categories'),
        backgroundColor: Colors.teal, // Teal app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 3 / 2,
            ),
            itemCount: _questionController.savedCategories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    QuizScreen(
                      category: _questionController.savedCategories[index],
                    ),
                    transition: Transition.fadeIn, // Smooth fade-in transition
                    duration: const Duration(
                        milliseconds: 500), // Transition duration
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.teal.shade200, // Lighter teal
                        Colors.teal.shade500, // Darker teal
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.question_answer,
                        size: 60,
                        color: Colors.white, // White icon for contrast
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _questionController.savedCategories[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          _questionController.savedSubtitles[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
