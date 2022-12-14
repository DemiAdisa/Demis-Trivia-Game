import 'package:demis_trivia_game/screens/game_home.dart';
import 'package:demis_trivia_game/screens/game_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demis Trivia Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
        ),
        initialRoute: "/",
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const GameHomeScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          // '/Game_Screen': (context) => GameScreen(),
        },
    );
  }
}
