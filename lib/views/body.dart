import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/question_controller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/views/question_card.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionController questionController = Get.find();
    final PageController pageController = questionController.pageController;

    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Obx(() => Text.rich(
                    TextSpan(
                      text:
                          "Question ${questionController.questionNumber.value}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: kSecondaryColour,
                            fontWeight: FontWeight.bold,
                          ),
                      children: [
                        TextSpan(
                          text: "/ ${questionController.questions.length}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: kSecondaryColour,
                                  ),
                        ),
                      ],
                    ),
                  )),
              const Divider(
                thickness: 2.0,
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: questionController.updateTheQnNum,
                  itemCount: questionController.questions.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      question: questionController.questions[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
