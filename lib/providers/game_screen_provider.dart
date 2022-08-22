import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GameScreenProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int maxQuestions;
  final String difficultyLvl;

  List? questions;
  int _currentQuestionCount = 0;
  int _score = 0;

  BuildContext context;

  GameScreenProvider(
      {required this.context,
      required this.difficultyLvl,
      required this.maxQuestions}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestions();
    // print("hello");
  }

  Future<void> _getQuestions() async {
    print(difficultyLvl);
    var _response = await _dio.get(
      "",
      queryParameters: {
        "amount": maxQuestions,
        "type": "boolean",
        "difficulty": difficultyLvl,
      },
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

    if (isCorrect) {
      _score++;
    }

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
        barrierDismissible: false,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "Game Over",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            content: Text("Score: $_score/$maxQuestions"),
          );
        });

    await Future.delayed(Duration(seconds: 3));

    Navigator.pop(context);
    Navigator.pushNamed(context, "/");
  }
}
