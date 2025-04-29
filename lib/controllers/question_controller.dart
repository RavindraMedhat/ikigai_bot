import 'dart:convert';

import 'package:get/get.dart';
import '../models/question.dart';
import '../services/api_service.dart';

class QuestionController extends GetxController {
  final List<Question> questions;
  var currentQuestionIndex = 0.obs;
  var ikigaiStatement = ''.obs;
  var ikigaiDescription = ''.obs;
  QuestionController({required this.questions});

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void prevQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  Future<void> submitAnswers(String email) async {
    List<Map<String, dynamic>> answerList =
        questions.map((q) => q.toJson()).toList();

    var response = await ApiService.evaluateAnswers(email, answerList);
    var data = jsonDecode(
      response[0]['output']
          .replaceFirst(RegExp(r'```json\n'), '')
          .replaceFirst(RegExp(r'\n```'), ''),
    );

    if (data['status'] == 'success') {
      if (data['next_action'] == 'follow_up') {
        List<Question> newQuestions =
            (data['questions'] as List)
                .map((q) => Question.fromJson(q))
                .toList();
        questions.addAll(newQuestions);
        currentQuestionIndex.value++;
      } else if (data['next_action'] == 'generate_report') {
        ikigaiStatement.value =
            data['ikigai_report']['ikigai_statement'];
        ikigaiDescription.value = data['ikigai_report']['description'];
        Get.offAllNamed('/report');
        Get.offAllNamed('/report');
      }
    }
  }
}
