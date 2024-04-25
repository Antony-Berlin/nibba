import 'dart:convert';

class EliesModel {
  final String question;
  final String answer;
  EliesModel({
    required this.question,
    required this.answer,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  factory EliesModel.fromMap(Map<String, dynamic> map) {
    return EliesModel(
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // factory EliesModel.fromJson(String source) => EliesModel.fromMap(json.decode(source));

  factory EliesModel.fromJson(Map<String, dynamic> json) {
    return EliesModel(
      
        question:json['question'] as String,
        answer: json['answer'] as String, 
    );
  }

}
