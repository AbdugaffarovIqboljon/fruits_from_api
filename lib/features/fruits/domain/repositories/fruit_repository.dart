import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/fruit.dart';

abstract class FruitRepository {
  Future<Either<Failure, List<Fruit>>> getFruits();
}
