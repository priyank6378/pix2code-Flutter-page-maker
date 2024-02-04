import 'dart:io';

void pageMakerAndSaver(String scaffoldBody, String scaffoldFooter, String outputFolder) {
  String page = '''
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('App Maker'),
        ),
        bottomNavigationBar: ${scaffoldFooter.isNotEmpty ? scaffoldFooter : 'null'},
        body: $scaffoldBody,
    );
  }
}


''';

  // current directory
  String curDir = Directory.current.path;

  // reading custom widgets file
  String customWidgetsCode = File('$curDir/flutterPageMaker/custom_widget.dart').readAsStringSync();

  page = page + customWidgetsCode;

  // save page in the file new_page.dart
  File('$outputFolder/new_page.dart').writeAsString(page);
}
