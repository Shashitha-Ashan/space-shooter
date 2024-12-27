import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:snake/bloc/count/count_cubit.dart';
import 'package:snake/components/bullet.dart';
import 'package:snake/player.dart';

import '../../space_ship_game.dart';

class EnemyUfo extends SpriteAnimationComponent
    with
        CollisionCallbacks,
        HasGameRef<SpaceShipGame>,
        FlameBlocReader<CountCubit, CountState> {
  EnemyUfo({
    super.position,
  }) : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
          angle: -66,
        );
  static const enemySize = 50.0;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(72, 72),
        texturePosition: Vector2(0, -10),
      ),
    );
    add(RectangleHitbox()..size = Vector2.all(enemySize * 1.5));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet) {
      bloc.increment();
      other.removeFromParent();
      removeFromParent();
    }
    if (other is Player) {
      bloc.lifeDecrement();
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }
}
