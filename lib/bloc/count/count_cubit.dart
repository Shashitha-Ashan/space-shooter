import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'count_state.dart';

class CountCubit extends Cubit<CountState> {
  CountCubit()
      : super(
          const CountState(score: 0, gameStatus: GameStatus.initial),
        );

  void increment() {
    emit(
      state.copyWith(
        score: state.score + 1,
        gameStatus: GameStatus.playing,
      ),
    );
  }

  void lifeDecrement() {
    emit(
      state.copyWith(
        life: state.life - 1,
      ),
    );
  }

  void reset() {
    emit(state.copyWith(score: 0, life: 5, gameStatus: GameStatus.initial));
  }
}
