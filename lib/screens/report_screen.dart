import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';

class ReportScreen extends StatelessWidget {
  final QuestionController questionController = Get.find();

  final boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 10,
        offset: Offset(0, 3),
      ),
    ],
  );

  Widget buildCard(String title, String content, Color titleColor) {
    return SizedBox(
      height: 200,
      width: 300,
      child: Container(
        decoration: boxDecoration,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: titleColor,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String content) {
    return SizedBox(width: 632,
      child: Container(
        width: double.infinity,
        decoration: boxDecoration,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF5FD), // Light blue background
      body: Obx(
        () => SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 60,
              ),
              child: Column(
                children: [
                  Text(
                    'Your Ikigai Report',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 30),

                  // Ikigai Statement & Description
                  // buildInfoCard(
                  //   "Ikigai Statement",
                  //   questionController.ikigaiStatement.value,
                  // ),
                  // buildInfoCard(
                  //   "Description",
                  //   questionController.ikigaiDescription.value,
                  // ),

                  SizedBox(height: 40),

                  // 2x2 Cards Layout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCard(
                        "Passion",
                        questionController.passion.value,
                        Colors.deepPurple,
                      ),
                      SizedBox(width: 32),
                      buildCard(
                        "Mission",
                        questionController.mission.value,
                        Colors.teal,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  buildInfoCard(
                    "Ikigai Statement",
                    questionController.ikigaiStatement.value,
                  ),
                  SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCard(
                        "Vocation",
                        questionController.vocation.value,
                        Colors.deepPurple,
                      ),
                      SizedBox(width: 32),
                      buildCard(
                        "Profession",
                        questionController.profession.value,
                        Colors.black,
                      ),
                    ],
                  ),

                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Add PDF or share functionality here
                    },
                    child: Text('Download My Ikigai Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3D5AFE),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
