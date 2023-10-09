import 'package:flutter/material.dart';
import 'package:fruits_from_api/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
