import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ikigai Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter your Email'),
              onChanged: (value) => authController.email.value = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.startConversation();
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
