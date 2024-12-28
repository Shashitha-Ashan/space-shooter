import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:snake/bloc/count/count_cubit.dart';
import 'package:snake/space_ship_game.dart';

class CountComponent extends TextComponent
    with
        FlameBlocListenable<CountCubit, CountState>,
        HasGameRef<SpaceShipGame> {
  CountComponent()
      : super(
            text: "0",
            textRenderer: TextPaint(
              style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            anchor: Anchor.center,
            size: Vector2(32, 32));
  @override
  int priority = 100;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    position = Vector2(game.size.x * 0.95, 20);
  }

  @override
  void onNewState(state) {
    text = state.score.toString();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = Vector2(game.size.x * 0.95, 20);
  }
}
