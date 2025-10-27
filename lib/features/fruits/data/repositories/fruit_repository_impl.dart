import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/fruit.dart';
import '../../domain/repositories/fruit_repository.dart';
import '../datasources/fruit_remote_data_source.dart';

class FruitRepositoryImpl implements FruitRepository {
  final FruitRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FruitRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Fruit>>> getFruits() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFruits = await remoteDataSource.getFruits();
        return Right(remoteFruits);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
