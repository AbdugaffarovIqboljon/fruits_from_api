import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../bloc/fruit_bloc.dart';
import '../bloc/fruit_event.dart';
import '../bloc/fruit_state.dart';
import '../widgets/fruit_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: const Text(
          'Fruits',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        elevation: 10,
      ),
      body: BlocBuilder<FruitBloc, FruitState>(
        builder: (context, state) {
          if (state is FruitLoading || state is FruitInitial) {
            return Center(
              child: Lottie.asset("lib/assets/lottie/loading_animation_blue.json"),
            );
          } else if (state is FruitLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: ListView.builder(
                itemCount: state.fruits.length,
                itemBuilder: (context, index) {
                  return FruitCard(fruit: state.fruits[index]);
                },
              ),
            );
          } else if (state is FruitError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FruitBloc>().add(GetFruitsEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
