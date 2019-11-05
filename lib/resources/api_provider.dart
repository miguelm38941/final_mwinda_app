import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:final_mwinda_app/models/quizz_theme.dart';
import 'package:final_mwinda_app/models/question.dart';

const String baseUrl = "https://opentdb.com/api.php";

Future<List<Question>> getQuestions(QuizzTheme quizzTheme, int total, String difficulty) async {
  String url = "$baseUrl?amount=$total&category=${quizzTheme.id}";
  if(difficulty != null) {
    url = "$url&difficulty=$difficulty";
  }
  http.Response res = await http.get(url);
  List<Map<String, dynamic>> questions = List<Map<String,dynamic>>.from(json.decode(res.body)["results"]);
  return Question.fromData(questions);
}