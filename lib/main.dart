import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/notepad_screen.dart';

void main() {
  runApp(const IBlockApp());
}

class IBlockApp extends StatelessWidget {
  const IBlockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IBlock - Bloc de Notas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Consolas',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const NotepadScreen(),
    );
  }
}