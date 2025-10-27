import 'package:equatable/equatable.dart';

abstract class FruitEvent extends Equatable {
  const FruitEvent();

  @override
  List<Object> get props => [];
}

class GetFruitsEvent extends FruitEvent {}
