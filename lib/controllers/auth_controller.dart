import 'dart:convert';

import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/question.dart';
import 'question_controller.dart';

class AuthController extends GetxController {
  var email = ''.obs;

  Future<void> startConversation() async {
    var response = await ApiService.initiate(email.value);
    var data = jsonDecode(
      response[0]['output']
          .replaceFirst(RegExp(r'```json\n'), '')
          .replaceFirst(RegExp(r'\n```'), ''),
    );

    if (data['status'] == 'success' && data['next_action'] == 'ask_questions') {
      List<Question> questions =
          (data['questions'] as List).map((q) => Question.fromJson(q)).toList();
      Get.put(QuestionController(questions: questions));
      Get.toNamed('/questions');
    }
  }
}
