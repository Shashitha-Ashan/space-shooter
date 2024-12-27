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
                fontSize: 48,
                fontWeight: FontWeight.bold),
          ),
        );

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    position = Vector2(game.size.x * 0.90, 0);
  }

  @override
  void onNewState(state) {
    text = state.score.toString();
  }
}
