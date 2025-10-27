import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/fruits/presentation/bloc/fruit_bloc.dart';
import 'features/fruits/presentation/bloc/fruit_event.dart';
import 'features/fruits/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: BlocProvider(
        create: (context) => di.sl<FruitBloc>()..add(GetFruitsEvent()),
        child: const HomePage(),
      ),
    );
  }
}
