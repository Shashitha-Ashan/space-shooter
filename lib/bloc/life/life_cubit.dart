import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'life_state.dart';

class LifeCubit extends Cubit<LifeState> {
  LifeCubit() : super(const LifeState.initial());

  void decrement() => emit(state.copyWith(life: state.life - 1));
}
