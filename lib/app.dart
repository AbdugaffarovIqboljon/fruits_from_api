import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
