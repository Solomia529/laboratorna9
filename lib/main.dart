import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF0B551F);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo with Dio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      home: const SignInScreen(),
    );
  }
}
