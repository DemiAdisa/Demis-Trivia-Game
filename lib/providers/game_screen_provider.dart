import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GameScreenProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int maxQuestions = 10;

  List? questions;
  int _currentQuestionCount = 0;

  BuildContext context;

  GameScreenProvider({required this.context}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestions();
    // print("hello");
  }

  Future<void> _getQuestions() async {
    var _response = await _dio.get(
      "",
      queryParameters: {"amount": 10, "type": "boolean", "difficulty": "easy"},
    );

    var _data = jsonDecode(_response.toString());

    questions = _data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]["question"];
  }

  Future<void> checkAnswer(String submittedValue) async {
    bool isCorrect =
        (submittedValue == questions![_currentQuestionCount]["correct_answer"]);

    _currentQuestionCount++;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });

    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);

    if (_currentQuestionCount >= maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              "Game Over",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            content: Text("Score: 0/0"),
          );
        });

    await Future.delayed(Duration(seconds: 3));

    Navigator.pop(context);
    Navigator.pop(context);
  }
}
