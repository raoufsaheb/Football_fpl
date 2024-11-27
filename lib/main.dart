import 'package:flutter/material.dart';
import 'package:football/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //previously primarySwatch: #344D67
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.teal,
          secondary: const Color(0x00000000),
          onSecondary: const Color(0xFFADE792),
          onPrimary: Colors.white,
          background: const Color(0xFFF3ECB0),
        ),
      ),
      routes: {'/': (context) => const Home()},
    );
  }
}
