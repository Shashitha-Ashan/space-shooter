import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:snake/components/bullet.dart';
import 'package:snake/space_ship_game.dart';

class Player extends SpriteAnimationComponent with HasGameRef<SpaceShipGame> {
  Player()
      : super(
          size: Vector2.all(100),
          position: Vector2(300, -200),
          anchor: Anchor.center,
        );

  final gravity = Vector2(0, 900);
  Vector2 velocity = Vector2(0, 0);
  late final SpawnComponent _bulletSpawner;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      'animations/player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(32, 48),
      ),
    );

    _bulletSpawner = SpawnComponent(
      period: 0.2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position + Vector2(position.x * -0.005, -size.y * 0.5),
        );
      },
      autoStart: false,
    );
    game.add(_bulletSpawner);
    add(PolygonHitbox([
      Vector2(size.x / 2, 0),
      Vector2(size.x, size.y),
      Vector2(0, size.y),
    ]));
  }

  void shoot() {
    _bulletSpawner.timer.start();
  }

  void stopShoot() {
    _bulletSpawner.timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameRef.joystick.direction != JoystickDirection.idle) {
      position += gameRef.joystick.delta * dt * 10;
      angle = gameRef.joystick.delta.screenAngle() * 0.6;
      velocity = Vector2.zero();
    }
    if (gameRef.joystick.direction == JoystickDirection.idle) {
      if (angle > 0 || angle < 0) {
        angle = angle * 0.9;
      }
      position += velocity * dt;
      velocity += gravity * dt;
    }
    // position.clamp(game.size * -0.5, game.size * 0.5);
    position.x = position.x.clamp(0 + size.x / 2, gameRef.size.x - size.x / 2);
    position.y = position.y.clamp(0 + size.y / 2, gameRef.size.y - size.y / 2);
  }
}
