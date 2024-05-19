import 'package:atma_kitchen/ProdukDashboardPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown, 
        hintColor:
            Colors.brown.shade200, 
      ),
      home: ProdukDashboardPage(),
    );
  }
}
