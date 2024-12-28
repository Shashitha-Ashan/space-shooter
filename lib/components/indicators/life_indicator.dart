import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:snake/bloc/count/count_cubit.dart';
import 'package:snake/space_ship_game.dart';

class LifeIndicator extends SpriteComponent
    with
        HasGameRef<SpaceShipGame>,
        FlameBlocListenable<CountCubit, CountState> {
  LifeIndicator()
      : super(
          size: Vector2(32, 32),
          anchor: Anchor.center,
        );
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load("heart.png");
    add(TextComponent(
      text: "5",
      position: Vector2(40, 0),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 28),
      ),
    ));
    position = Vector2(game.size.x * 0.80, 20);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  int priority = 100;
  @override
  void onNewState(state) {
    children.query<TextComponent>().forEach(remove);
    add(TextComponent(
      text: state.life.toString(),
      position: Vector2(40, 0),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 28),
      ),
    ));
    if (state.life < 0) {
      game.pauseEngine();
      game.overlays.add("GameOver");
      bloc.reset();
      children.query<TextComponent>().forEach(remove);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = Vector2(game.size.x * 0.80, 20);
  }
}
