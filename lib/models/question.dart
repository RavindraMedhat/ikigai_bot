class Question {
  final String questionText;
  String answerText;

  Question({required this.questionText, this.answerText = ''});

  Map<String, dynamic> toJson() {
    return {"question_text": questionText, "answer_text": answerText};
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(questionText: json['question_text']);
  }
}
