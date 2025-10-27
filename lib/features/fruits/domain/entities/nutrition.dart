import 'package:equatable/equatable.dart';

class Nutrition extends Equatable {
  final int calories;
  final double fat;
  final double sugar;
  final double carbohydrates;
  final double protein;

  const Nutrition({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  @override
  List<Object> get props => [calories, fat, sugar, carbohydrates, protein];
}
