import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/question_controller.dart';

class QuestionScreen extends StatelessWidget {
  final QuestionController questionController = Get.find();
  final AuthController authController = Get.find();
  final TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Answer Questions')),
      body: Obx(() {
        final question =
            questionController.questions[questionController
                .currentQuestionIndex
                .value];
        answerController.text = question.answerText;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(question.questionText, style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              TextField(
                controller: answerController,
                maxLines: 5,
                onChanged: (value) {
                  question.answerText = value;
                },
                decoration: InputDecoration(
                  hintText: "Your Answer",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (questionController.currentQuestionIndex.value > 0)
                    ElevatedButton(
                      onPressed: () {
                        questionController.prevQuestion();
                      },
                      child: Text('Previous'),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (questionController.currentQuestionIndex.value ==
                          questionController.questions.length - 1) {
                        questionController.submitAnswers(
                          authController.email.value,
                        );
                      } else {
                        questionController.nextQuestion();
                      }
                    },
                    child: Text(
                      questionController.currentQuestionIndex.value ==
                              questionController.questions.length - 1
                          ? 'Submit'
                          : 'Next',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
