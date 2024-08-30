import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/question_controller.dart';
import 'package:flutter_application_1/models/questions_model.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/views/option.dart';
import 'package:get/get.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    // Obtain the QuestionController instance
    final QuestionController questionController = Get.find();

    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questions,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Options(
                text: question.options[index],
                index: index,
                press: () => questionController.checkAnswer(question, index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
