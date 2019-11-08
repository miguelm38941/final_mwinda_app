import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' as prefix0;

enum Type {
  multiple,
  boolean
}

enum Difficulty {
  easy,
  medium,
  hard
}

class Question {
  final String categoryName;
  final Type type;
  final Difficulty difficulty;
  final String question;
  final String correctAnswer;
  List<dynamic> incorrectAnswers;

  Question({this.categoryName, this.type, this.difficulty, this.question, this.correctAnswer, this.incorrectAnswers});

  Question.fromMap(Map<String, dynamic> data):
    //DebugPrint(data.toString());
    categoryName = data["category"],
    type = Type.multiple, //data["type"] == "multiple" ? Type.multiple : Type.boolean,
    difficulty = Difficulty.easy, //data["difficulty"] == "easy" ? Difficulty.easy : data["difficulty"] == "medium" ? Difficulty.medium : Difficulty.hard,
    question = data["question"],
    correctAnswer = data["correct_answer"],
    incorrectAnswers = data["incorrect_answers"].split(', ');


  static List<Question> fromData(List<Map<String,dynamic>> data){
    return data.map((question) => Question.fromMap(question)).toList();
  }

}