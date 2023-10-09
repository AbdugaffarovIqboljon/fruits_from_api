import 'package:flutter/material.dart';
import 'package:fruits_from_api/models/fruit_model.dart';

class DetailPage extends StatelessWidget {
  final Fruit fruits;

  const DetailPage({super.key, required this.fruits});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
        ),
        title: const Text(
          "All Specifications",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepOrange,
                        width: 1,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    height: MediaQuery.sizeOf(context).height / 2.5,
                    width: MediaQuery.sizeOf(context).width,
                    child: const Image(
                      image: AssetImage(
                        "lib/assets/images/nathan-dumlao-SlUoDl_SBMs-unsplash.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  fruits.name,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 8),
                Card(
                  margin: const EdgeInsets.only(top: 8),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Column(
                      children: [
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Name : ",
                          secondText: fruits.name,
                        ),
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Genus: ",
                          secondText: fruits.genus,
                        ),
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Family: ",
                          secondText: fruits.family.toString(),
                        ),
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Order: ",
                          secondText: fruits.order,
                        ),
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Carbohydrates: ",
                          secondText: fruits.nutrition.carbohydrates.toString(),
                        ),
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Sugar: ",
                          secondText: fruits.nutrition.sugar.toString(),
                        ),
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Fat: ",
                          secondText: fruits.nutrition.fat.toString(),
                        ),
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Calories: ",
                          secondText: fruits.nutrition.calories.toString(),
                        ),
                        InformationWidget(
                          fruits: fruits,
                          firstText: "Protein: ",
                          secondText: fruits.nutrition.protein.toString(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    super.key,
    required this.fruits,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;
  final Fruit fruits;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          secondText.isNotEmpty ? secondText : "No Information",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: secondText.isEmpty ? Colors.grey : null,
          ),
        ),
      ],
    );
  }
}
