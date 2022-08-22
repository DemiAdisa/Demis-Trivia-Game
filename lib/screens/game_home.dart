import 'package:demis_trivia_game/screens/game_screen.dart';
import 'package:flutter/material.dart';

enum MaxQuestions { ten, fifteen, twenty }

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({Key? key}) : super(key: key);

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  List<String>? difficultyLevels = ["Easy", "Medium", "Hard"];

  double _difficultyIndex = 0;
  int _questionNumber = 10;
  MaxQuestions? _maxQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Demi's Trivia Game",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                difficultySliderUI(),
                SizedBox(height: 10,),
                maxQuestionsSelector(),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                          maxQuestions: _questionNumber,
                          difficulty:
                              difficultyLevels![_difficultyIndex.toInt()]
                                  .toLowerCase()),
                    ));
              },
              child: const Text("START"),
            )
          ],
        ),
      ),
    );
  }

  Widget difficultySliderUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              min: 0,
              max: 2,
              value: _difficultyIndex,
              divisions: 2,
              label: difficultyLevels![_difficultyIndex.toInt()],
              onChanged: (_value) {
                setState(() {
                  _difficultyIndex = _value;
                });
              },
            ),
            const Text(
              "Choose Difficulty",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget maxQuestionsSelector() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                      child: RadioListTile<MaxQuestions>(
                          contentPadding: const EdgeInsets.all(0.0),
                          value: MaxQuestions.ten,
                          tileColor: Colors.deepPurple,
                          title: const Text(
                            "15",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          groupValue: _maxQuestions,
                          onChanged: (val) {
                            setState(() {
                              _maxQuestions = val;
                              _questionNumber = 15;
                            });
                          })),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: RadioListTile<MaxQuestions>(
                          contentPadding: const EdgeInsets.all(0.0),
                          value: MaxQuestions.fifteen,
                          tileColor: Colors.deepPurple,
                          title: const Text(
                            "20",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          groupValue: _maxQuestions,
                          onChanged: (val) {
                            setState(() {
                              _maxQuestions = val;
                              _questionNumber = 20;
                            });
                          })),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: RadioListTile<MaxQuestions>(
                          contentPadding: const EdgeInsets.all(0.0),
                          value: MaxQuestions.twenty,
                          tileColor: Colors.deepPurple,
                          title: const Text(
                            "25",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          groupValue: _maxQuestions,
                          onChanged: (val) {
                            setState(() {
                              _maxQuestions = val;
                              _questionNumber = 25;
                            });
                          })),
                ],
              ),
            ),
            const Text(
              "Max Questions (Default is 10)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

// // Widget maxQuestionsUI() {
// //   return Radio<int>(
// //
// //   );
// }
}
