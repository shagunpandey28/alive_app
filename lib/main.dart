import 'package:alive_app/core/constants/app_theme.dart';
import 'package:alive_app/views/home_screen.dart';
import 'package:alive_app/views/login_screen.dart';
import 'package:alive_app/views/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'/',
      theme: AppTheme.lightTheme,
      routes: {
        '/':(context) => const SplashScreen(),
        '/login_screen':(context)=> LoginScreen(),
        '/home_screen':(context)=> HomeScreen(),
      }
    );
  }
}


