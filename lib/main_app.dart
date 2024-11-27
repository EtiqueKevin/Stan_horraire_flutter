import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'screens/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor:const Color.fromARGB(255, 255, 255, 255),
        surface: const Color.fromARGB(255, 12, 165, 211),
        primary: const Color.fromARGB(255, 12, 165, 211),
        onPrimary: Colors.white,
        secondary: Color.fromARGB(255, 244, 255, 255),
        
        tertiary:Color.fromARGB(255, 244, 255, 255) ,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),  
        titleMedium: TextStyle(
          color:const Color.fromARGB(255, 12, 165, 211),
          fontSize: 24,
        ),
        titleSmall: TextStyle(
          color:const Color.fromARGB(255, 12, 165, 211),
          fontSize: 20,
        ),
        headlineMedium: TextStyle(
          color:Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        bodyLarge: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color:Color.fromARGB(255, 0, 0, 0),
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color:Color.fromARGB(255, 0, 0, 0),
          fontSize: 14,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 12, 165, 211),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(98, 0, 0, 0),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor:const Color.fromARGB(255, 255, 255, 255),
        surface: const Color.fromARGB(255, 12, 165, 211),
        primary: const Color.fromARGB(255, 12, 165, 211),
        onPrimary: Colors.white,
        secondary: Color.fromARGB(255, 29, 29, 29),
        
        tertiary:const Color.fromARGB(255, 27, 27, 27) ,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color:Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),  
        titleMedium: TextStyle(
          color:const Color.fromARGB(255, 12, 165, 211),
          fontSize: 24,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 12, 165, 211),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
