import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/fruit.dart';
import '../../domain/usecases/get_fruits.dart';
import 'fruit_event.dart';
import 'fruit_state.dart';

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
    if (failure is ServerFailure) {
      return AppStrings.serverFailureMessage;
    } else if (failure is NetworkFailure) {
      return AppStrings.networkFailureMessage;
    } else if (failure is CacheFailure) {
      return AppStrings.cacheFailureMessage;
    } else {
      return AppStrings.unexpectedErrorMessage;
    }
  }
}
