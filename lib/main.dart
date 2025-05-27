import 'package:flutter/material.dart';
import 'games/gato_game.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gato - Proyecto MM',
      theme: ThemeData.dark(),
      home: GatoGameScreen(),
    );
  }
}
