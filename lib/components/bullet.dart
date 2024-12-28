import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../space_ship_game.dart';

class Bullet extends PositionComponent with HasGameReference<SpaceShipGame> {
  Bullet({
    super.position,
  }) : super(size: Vector2(40, 10), anchor: Anchor.center, angle: -33);
  late Sprite sprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load("bullet.png");
    add(RectangleHitbox(
      collisionType: CollisionType.passive,
    ));
    game.shootAudioPool.start();
  }

  @override
  void render(Canvas canvas) {
    sprite.render(canvas, size: size);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * -500;

    if (position.y < -height) {
      removeFromParent();
    }
  }
}
