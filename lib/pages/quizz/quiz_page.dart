import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:final_mwinda_app/models/quizz_theme.dart';
import 'package:final_mwinda_app/models/question.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:final_mwinda_app/pages/quizz/quiz_finished.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final QuizzTheme quizzTheme;

  const QuizPage({Key key, @required this.questions, this.quizzTheme}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextStyle _questionStyle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  int _currentIndex = 0;
  final Map<int,dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context){
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if(!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }
    
        return WillPopScope(
    

      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(widget.quizzTheme.theme),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
                height: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text("${_currentIndex+1}"),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(HtmlUnescape().convert(widget.questions[_currentIndex].question),
                          softWrap: true,
                          style: _questionStyle,),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...options.map((option)=>RadioListTile(
                          title: Text(HtmlUnescape().convert("$option")),
                          groupValue: _answers[_currentIndex],
                          value: option,
                          onChanged: (value){
                            setState(() {
                              _answers[_currentIndex] = option;
                            });
                          },
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        child: Text( _currentIndex == (widget.questions.length - 1) ? "Soumettre" : "Suivant"),
                        onPressed: _nextSubmit,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _nextSubmit() {
    
      AudioCache player;
      player = new AudioCache();

    if(_answers[_currentIndex] == null) {
      _key.currentState.showSnackBar(SnackBar(
        content: Text("Choisissez votre réponse avant de continuer."),
      ));
      return;
    }
    if(_currentIndex < (widget.questions.length - 1)){

      const alarmAudioPath = "audio/next.wav";
      player.play(alarmAudioPath);

      setState(() {
          _currentIndex++;
      });

    } else {

      const alarmAudioPath = "audio/fanfare.mp3";
      player.play(alarmAudioPath);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => QuizFinishedPage(questions: widget.questions, answers: _answers)
      ));
    }
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text("Voulez-vous quitter le quizz ?"),
          title: Text("Attention!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Oui"),
              onPressed: (){
                Navigator.pop(context,true);
              },
            ),
            FlatButton(
              child: Text("Non"),
              onPressed: (){
                Navigator.pop(context,false);
              },
            ),
          ],
        );
      }
    );
  }
}