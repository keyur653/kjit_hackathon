import 'package:attendance_app/classes.dart';
import 'package:attendance_app/pages/login.dart';
import 'package:attendance_app/widgets/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Checker App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  AddItemPage(),
      home: SubjectListScreen(),
    );
  }
}
