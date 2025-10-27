import '../../domain/entities/fruit.dart';
import 'nutrition_model.dart';

class FruitModel extends Fruit {
  const FruitModel({
    required super.name,
    required super.id,
    required super.family,
    required super.order,
    required super.genus,
    required super.nutrition,
  });

  factory FruitModel.fromJson(Map<String, dynamic> json) {
    return FruitModel(
      name: json['name'] as String,
      id: json['id'] as int,
      family: json['family'] as String,
      order: json['order'] as String,
      genus: json['genus'] as String,
      nutrition: NutritionModel.fromJson(json['nutritions'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'family': family,
      'order': order,
      'genus': genus,
      'nutritions': (nutrition as NutritionModel).toJson(),
    };
  }
}
