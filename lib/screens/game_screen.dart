import 'package:demis_trivia_game/providers/game_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;
  final String difficulty;
  final int maxQuestions;

  GameScreenProvider? _pageProvider;

  GameScreen({required this.maxQuestions, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_context) => GameScreenProvider(
          context: _context,
          difficultyLvl: difficulty,
          maxQuestions: maxQuestions),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      _pageProvider = _context.watch<GameScreenProvider>();

      if (_pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: 5,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.checkAnswer("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.checkAnswer("False");
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
