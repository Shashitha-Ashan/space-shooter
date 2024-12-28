import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:snake/bloc/count/count_cubit.dart';
import 'package:snake/components/bullet.dart';
import 'package:snake/player.dart';

import '../../space_ship_game.dart';

class Enemy extends SpriteAnimationComponent
    with
        CollisionCallbacks,
        HasGameRef<SpaceShipGame>,
        FlameBlocReader<CountCubit, CountState> {
  Enemy({
    super.position,
  }) : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
        );
  static const enemySize = 40.0;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    animation = await game.loadSpriteAnimation(
      'animations/asteroid.png',
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: .2,
        textureSize: Vector2(128, 128),
        texturePosition: Vector2(0, -10),
      ),
    );
    add(CircleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet) {
      bloc.increment();
      removeFromParent();
    }
    if (other is Player) {
      bloc.lifeDecrement();
      removeFromParent();
    }
    game.explotionAudioPool.start();
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
