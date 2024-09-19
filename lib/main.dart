import 'package:flutter/material.dart';
import 'package:todo/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "T A S K",
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
