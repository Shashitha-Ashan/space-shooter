part of 'life_cubit.dart';

class LifeState extends Equatable {
  const LifeState({
    required this.life,
  });
  final int life;

  const LifeState.initial() : life = 3;

  LifeState copyWith({
    int? life,
  }) {
    return LifeState(
      life: life ?? this.life,
    );
  }

  @override
  List<Object> get props => [life];
}
