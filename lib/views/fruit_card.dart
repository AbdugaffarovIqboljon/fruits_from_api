import "package:flutter/material.dart";
import "package:fruits_from_api/models/fruit_model.dart";
import "package:fruits_from_api/pages/detail_page.dart";

class FruitCard extends StatelessWidget {
  final Fruit fruit;

  const FruitCard({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white10,
        ),
      ),
      child: ListTile(
        minVerticalPadding: 20,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        title: Text(
          fruit.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            fruit.family,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black45),
          ),
        ),
        trailing: Text(fruit.genus),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(fruits: fruit),
              ));
        },
      ),
    );
  }
}
