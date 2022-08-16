import 'package:flutter/material.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({Key? key}) : super(key: key);

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {

  List<String>? difficultyLevels = ["Easy", "Medium", "Hard"];

  double _difficultyIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Demi's Trivia Game",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                difficultySliderUI(),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/Game_Screen");
              },
              child: const Text("START"),
            )
          ],
        ),
      ),
    );
  }

  Widget difficultySliderUI() {
    return Slider(
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
    );
  }

  Widget categorySelectorUI() {
    return Text("Nothing");
  }

// // Widget maxQuestionsUI() {
// //   return Radio<int>(
// //
// //   );
// }
}
