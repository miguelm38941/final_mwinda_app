import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:final_mwinda_app/models/quizz_theme.dart';
import 'package:final_mwinda_app/models/question.dart';

const String baseUrl = "https://www.mwinda-rdc.org";

Future<List<Question>> getQuestions(QuizzTheme quizzTheme, int total, String difficulty) async {
  //String url = "$baseUrl?amount=$total&category=${quizzTheme.id}";
  String url = "$baseUrl/mobileapi/quizz/questions_set/11";
  debugPrint(url);
  /*if(difficulty != null) {
    url = "$url&difficulty=$difficulty";
  }*/
  http.Response res = await http.get(url);
  //debugPrint("rrrrrr ----- " + res.body.toString());
  List<Map<String, dynamic>> questions = List<Map<String,dynamic>>.from(json.decode(res.body)["result"]);
  //debugPrint("ttttttttttt ----- " + questions.toString());
  return Question.fromData(questions);
}