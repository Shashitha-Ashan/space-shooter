part of 'count_cubit.dart';

enum GameStatus { initial, playing, paused, over }

class CountState extends Equatable {
  final int score;
  final GameStatus gameStatus;
  final int life;
  const CountState({
    this.score = 0,
    this.gameStatus = GameStatus.initial,
    this.life = 5,
  });

  CountState copyWith({
    int? score,
    GameStatus? gameStatus,
    int? life,
  }) {
    return CountState(
      score: score ?? this.score,
      gameStatus: gameStatus ?? this.gameStatus,
      life: life ?? this.life,
    );
  }

  @override
  List<Object?> get props => [score, gameStatus, life];
}
