import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:final_mwinda_app/models/quizz_theme.dart';
import 'package:final_mwinda_app/models/question.dart';
import 'package:final_mwinda_app/resources/api_provider.dart';
import 'package:final_mwinda_app/pages/quizz/error.dart';
import 'package:final_mwinda_app/pages/quizz/quiz_page.dart';

class QuizOptionsDialog extends StatefulWidget {
  final QuizzTheme quizzTheme;

  const QuizOptionsDialog({Key key, this.quizzTheme}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  int _noOfQuestions;
  String _difficulty;
  bool processing;

  @override
  void initState() { 
    super.initState();
    _noOfQuestions = 10;
    _difficulty = "easy";
    processing = false;
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey.shade200,
              child: Text(
                widget.quizzTheme.theme, 
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(),
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              child: MaterialButton(
                child: Text(
                  'Go',
                  style: new TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.all(20.0),
                color: Colors.red,
                textColor: Colors.white,
                highlightColor: Colors.redAccent,
                splashColor: Colors.redAccent,
                height: 120.0,
                elevation: 2,
                highlightElevation: 2,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                onPressed: _startQuiz,
              ),
              /*child: new InkWell(// this is the one you are looking for..........
                onTap: () => homePageRoute,
        child: ClipOval(
          child: Container(
            color: Colors.blue,
            height: 120.0, // height of the button
            width: 120.0, // width of the button
            child: Center(child: Text('A Circular Button', style: ,)),
          ),
        ),
              ),*/
            ),

            /*Text("Select Total Number of Questions"),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 16.0,
                spacing: 16.0,
                children: <Widget>[
                  SizedBox(width: 0.0),
                  ActionChip(
                    label: Text("10"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 10 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(10),
                  ),
                  ActionChip(
                    label: Text("20"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 20 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(20),
                  ),
                  ActionChip(
                    label: Text("30"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 30 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(30),
                  ),
                  ActionChip(
                    label: Text("40"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 40 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(40),
                  ),
                  ActionChip(
                    label: Text("50"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 50 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(50),
                  ),
                  
                ],
              ),
            ),*/
            /*SizedBox(height: 20.0),
            Text("Select Difficulty"),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 16.0,
                spacing: 16.0,
                children: <Widget>[
                  SizedBox(width: 0.0),
                  ActionChip(
                    label: Text("Any"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == null ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty(null),
                  ),
                  ActionChip(
                    label: Text("Easy"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "easy" ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("easy"),
                  ),
                  ActionChip(
                    label: Text("Medium"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "medium" ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("medium"),
                  ),
                  ActionChip(
                    label: Text("Hard"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "hard" ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("hard"),
                  ),
                  
                ],
              ),
            ),*/
            /*SizedBox(height: 20.0),
            processing ? CircularProgressIndicator() : RaisedButton(
              child: Text("Start Quiz"),
              onPressed: _startQuiz,
            ),*/
            SizedBox(height: 20.0),
          ],
        ),
      );
  }

  _selectNumberOfQuestions(int i) {
    setState(() {
      _noOfQuestions = i;
    });
  }

  _selectDifficulty(String s) {
    setState(() {
      _difficulty=s;
    });
  }

  void _startQuiz() async {

    AudioCache player;
    player = new AudioCache();
    const alarmAudioPath = "audio/next.wav";
    player.play(alarmAudioPath);

    setState(() {
      processing=true;
    });
    try {

      List<Question> questions =  await getQuestions(widget.quizzTheme, _noOfQuestions, _difficulty);
      Navigator.pop(context);
      if(questions.length < 1) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ErrorPage(message: "Ce thème ne contient pas de question.",)
        ));
        return;
      }
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => QuizPage(questions: questions, quizzTheme: widget.quizzTheme,)
      ));
    }on SocketException catch (_) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ErrorPage(message: "Serveurs injoignable, \n Vérifiez votre connection.",)
      ));
    } catch(e){
      print(e.message);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ErrorPage(message: "Unexpected error trying to connect to the API",)
      ));
    }
    setState(() {
      processing=false;
    });
  }
}