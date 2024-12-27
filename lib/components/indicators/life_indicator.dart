import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:snake/bloc/count/count_cubit.dart';
import 'package:snake/space_ship_game.dart';

class LifeIndicator extends TextComponent
    with
        FlameBlocListenable<CountCubit, CountState>,
        HasGameRef<SpaceShipGame> {
  LifeIndicator()
      : super(
          textRenderer: TextPaint(
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 0, 0),
                fontSize: 48,
                fontWeight: FontWeight.bold),
          ),
        );

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    text = '3';
    position = Vector2(game.size.x * 0.80, 0);
  }

  @override
  void onNewState(state) {
    text = state.life.toString();
  }
}
