import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../space_ship_game.dart';

class ShootButton extends PositionComponent
    with HasGameRef<SpaceShipGame>, TapCallbacks {
  ShootButton()
      : super(
          size: Vector2(80, 50),
          angle: -0.9,
          anchor: Anchor.center,
        );

  late Sprite sprite;
  late CircleComponent circleComponent;

  @override
  FutureOr<void> onLoad() async {
    position = Vector2(game.size.x - 80,
        game.size.y - 80); // game.size.x * 0.90, game.size.y * 0.8

    super.onLoad();

    circleComponent = CircleComponent(
      radius: 55,
      position: size / 2,
      paint: Paint()..color = const Color.fromARGB(20, 255, 255, 255),
      anchor: Anchor.center,
    );

    add(circleComponent);

    sprite = await Sprite.load('bullet.png');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    sprite.render(canvas, size: size);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    game.player.stopShoot();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    game.player.shoot();
  }
}
