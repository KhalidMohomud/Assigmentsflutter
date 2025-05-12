import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manystore/users/Auth/Login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter many store',
      theme: ThemeData(primarySwatch: customSwatch),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

// ...existing code... template colores ku habeenee

const MaterialColor customSwatch = MaterialColor(
  0xFF0C3150,
  <int, Color>{
    50: Color(0xFF0C3150),
    100: Color(0xFF0C3150),
    200: Color(0xFF0C3150),
    300: Color(0xFF0C3150),
    400: Color(0xFF0C3150),
    500: Color(0xFF0C3150),
    600: Color(0xFF0C3150),
    700: Color(0xFF0C3150),
    800: Color(0xFF0C3150),
    900: Color(0xFF0C3150),
  },
);
// ...existing code...