import 'package:flutter/material.dart';
import 'package:fruits_from_api/models/fruit_model.dart';
import 'package:lottie/lottie.dart';

import '../services/network_service.dart';
import '../views/fruit_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Fruit> items = [];

  void fetchEmojis() async {
    final data = await Network.methodGet(api: Network.api);
    if (data != null) {
      items = Network.parseFruitList(data);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something bad happened')));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchEmojis();
  }

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
      body: items.isEmpty
          ? Center(
              child:
                  Lottie.asset("lib/assets/lottie/loading_animation_blue.json"),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return FruitCard(fruit: items[index]);
                },
              ),
            ),
    );
  }
}
