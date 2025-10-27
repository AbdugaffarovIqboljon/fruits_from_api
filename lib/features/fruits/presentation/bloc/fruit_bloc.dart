import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/fruit.dart';
import '../../domain/usecases/get_fruits.dart';
import 'fruit_event.dart';
import 'fruit_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class FruitBloc extends Bloc<FruitEvent, FruitState> {
  final GetFruits getFruits;

  FruitBloc({required this.getFruits}) : super(FruitInitial()) {
    on<GetFruitsEvent>(_onGetFruits);
  }

  Future<void> _onGetFruits(
    GetFruitsEvent event,
    Emitter<FruitState> emit,
  ) async {
    emit(FruitLoading());
    final failureOrFruits = await getFruits(NoParams());
    emit(_eitherLoadedOrErrorState(failureOrFruits));
  }

  FruitState _eitherLoadedOrErrorState(
    Either<Failure, List<Fruit>> failureOrFruits,
  ) {
    return failureOrFruits.fold(
      (failure) => FruitError(message: _mapFailureToMessage(failure)),
      (fruits) => FruitLoaded(fruits: fruits),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
