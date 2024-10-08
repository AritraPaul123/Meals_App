import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/views/screens/home.dart';
import 'package:meals_app/views/screens/tabs_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
            seedColor: const Color.fromARGB(255, 131, 57, 0)
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme()
      ),
      home: const TabsScreen(),
    );
  }
}