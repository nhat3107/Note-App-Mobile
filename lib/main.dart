import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/note_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_note_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NoteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _themeMode,
      routes: {
        '/': (ctx) => HomeScreen(toggleTheme: _toggleTheme),
        '/add': (ctx) => const AddNoteScreen(),
      },
    );
  }
}
