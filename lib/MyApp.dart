import 'package:flutter/material.dart';
import 'views/HomeMaterial.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spending Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomeMaterial(),
    );
  }
}
