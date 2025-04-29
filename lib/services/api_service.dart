import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      "https://ravindrasinh.app.n8n.cloud/webhook/ikigai";

  static Future<List<dynamic>> initiate(String email) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "emailId": email,
        "action": "initiate",
        "answers": [],
      }),
    );
    return json.decode(response.body);
  }

  static Future<List<dynamic>> evaluateAnswers(
    String email,
    List<Map<String, dynamic>> answers,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "emailId": email,
        "action": "evalute-answer",
        "answers": answers,
      }),
    );
    return json.decode(response.body);
  }
}
