import 'package:flutter/material.dart';
import 'package:movie_information_app/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, //다크모드
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
