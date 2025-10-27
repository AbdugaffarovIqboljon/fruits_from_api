import 'package:equatable/equatable.dart';
import 'nutrition.dart';

class Fruit extends Equatable {
  final String name;
  final int id;
  final String family;
  final String order;
  final String genus;
  final Nutrition nutrition;

  const Fruit({
    required this.name,
    required this.id,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutrition,
  });

  @override
  List<Object> get props => [name, id, family, order, genus, nutrition];
}
