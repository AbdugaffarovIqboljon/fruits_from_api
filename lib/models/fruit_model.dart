class Fruit {
  String name;
  int id;
  String family;
  String order;
  String genus;
  Nutrition nutrition;

  Fruit({
    required this.name,
    required this.id,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutrition,
  });

  factory Fruit.fromJson(Map<String, Object?> json) => Fruit(
        name: json["name"] as String,
        id: json["id"] as int,
        family: json["family"] as String,
        order: json["order"] as String,
        genus: json["genus"] as String,
        nutrition:
            Nutrition.fromJson(json["nutritions"] as Map<String, Object?>),
      );
}

class Nutrition {
  int calories;
  double fat;
  double sugar;
  double carbohydrates;
  double protein;

  Nutrition({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  factory Nutrition.fromJson(Map<String, Object?> json) {
    return Nutrition(
      calories: json["calories"] as int,
      fat: json["fat"] as double,
      sugar: json["sugar"] as double,
      carbohydrates: json["carbohydrates"] as double,
      protein: json["protein"] as double,
    );
  }
}
