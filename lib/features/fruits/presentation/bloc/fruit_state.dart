import 'package:equatable/equatable.dart';
import '../../domain/entities/fruit.dart';

abstract class FruitState extends Equatable {
  const FruitState();

  @override
  List<Object> get props => [];
}

class FruitInitial extends FruitState {}

class FruitLoading extends FruitState {}

class FruitLoaded extends FruitState {
  final List<Fruit> fruits;

  const FruitLoaded({required this.fruits});

  @override
  List<Object> get props => [fruits];
}

class FruitError extends FruitState {
  final String message;

  const FruitError({required this.message});

  @override
  List<Object> get props => [message];
}
