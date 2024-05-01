import 'package:atma_kitchen/Profile.dart';
import 'package:flutter/material.dart';
// import 'package:atma_kitchen/Presensi.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown, // Atur primary color menjadi brown
        hintColor: Colors.brown.shade200, // Atur accent color menjadi brown muda
      ),
      home: const Profile(),
    );
  }
}