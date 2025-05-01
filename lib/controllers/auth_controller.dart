// import 'dart:convert';

// import 'package:get/get.dart';
// import '../services/api_service.dart';
// import '../models/question.dart';
// import 'question_controller.dart';

// class AuthController extends GetxController {
//   var email = ''.obs;

//   Future<void> startConversation() async {
//     var response = await ApiService.initiate(email.value);
//     var data = jsonDecode(
//       response[0]['output']
//           .replaceFirst(RegExp(r'```json\n'), '')
//           .replaceFirst(RegExp(r'\n```'), ''),
//     );

//     if (data['status'] == 'success' && data['next_action'] == 'ask_questions') {
//       List<Question> questions =
//           (data['questions'] as List).map((q) => Question.fromJson(q)).toList();
//       Get.put(QuestionController(questions: questions));
//       Get.toNamed('/questions');
//     }
//   }
// }


import 'dart:convert';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/question.dart';
import 'question_controller.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var isLoading = false.obs; // <-- Add loading state

  Future<void> startConversation() async {
    if (email.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true; // show loader
    try {
      var response = await ApiService.initiate(email.value);
      var data = jsonDecode(
        response[0]['output']
            .replaceFirst(RegExp(r'```json\n'), '')
            .replaceFirst(RegExp(r'\n```'), ''),
      );

      if (data['status'] == 'success' &&
          data['next_action'] == 'ask_questions') {
        List<Question> questions =
            (data['questions'] as List)
                .map((q) => Question.fromJson(q))
                .toList();
        Get.put(QuestionController(questions: questions));
        Get.toNamed('/questions');
      } else {
        Get.snackbar(
          'Error',
          'Unexpected response from server',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false; // hide loader
    }
  }
}
