import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/network_info.dart';
import 'features/fruits/data/datasources/fruit_remote_data_source.dart';
import 'features/fruits/data/repositories/fruit_repository_impl.dart';
import 'features/fruits/domain/repositories/fruit_repository.dart';
import 'features/fruits/domain/usecases/get_fruits.dart';
import 'features/fruits/presentation/bloc/fruit_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Fruits
  // Bloc
  sl.registerFactory(
    () => FruitBloc(getFruits: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetFruits(sl()));

  // Repository
  sl.registerLazySingleton<FruitRepository>(
    () => FruitRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FruitRemoteDataSource>(
    () => FruitRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}
