import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:snake/bloc/count/count_cubit.dart';
import 'package:snake/components/collidable/astroid.dart';
import 'package:snake/components/indicators/count_component.dart';
import 'package:snake/components/collidable/enemy.dart';
import 'package:snake/components/collidable/enemy_UFO.dart';
import 'package:snake/components/indicators/life_indicator.dart';
import 'package:snake/components/joystick.dart';
import 'package:snake/components/parralax_bkg.dart';
import 'package:snake/components/shoot_button.dart';

import 'package:snake/game_world.dart';
import 'package:snake/player.dart';

class SpaceShipGame extends FlameGame with HasCollisionDetection {
  SpaceShipGame() : super(world: SpaceWorld()) {
    enemySpawner = SpawnComponent(
      factory: (index) => Enemy(),
      period: 1,
      area: Rectangle.fromLTRB(0, 0, 0, 0),
    );

    enemyUfoSpawner = SpawnComponent(
      factory: (index) => EnemyUfo(),
      period: 3,
      area: Rectangle.fromLTRB(0, 0, 0, 0),
    );

    asteroidSpawner = SpawnComponent(
      factory: (index) => Asteroid(),
      period: 1,
      area: Rectangle.fromLTRB(0, 0, 0, 0),
    );
  }

  final SpaceShipGameJoystick joystick = SpaceShipGameJoystick();
  final ParralaxBackground parallax = ParralaxBackground();
  final Player player = Player();
  final LifeIndicator lifeIndicator = LifeIndicator();
  final CountComponent countComponent = CountComponent();

  late SpawnComponent enemySpawner;
  late SpawnComponent enemyUfoSpawner;
  late SpawnComponent asteroidSpawner;
  // Audio pools
  late AudioPool shootAudioPool;
  late AudioPool explotionAudioPool;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgm.mp3', volume: .40);
    // Audio pool init
    shootAudioPool = await FlameAudio.createPool('shoot.wav', maxPlayers: 2);
    explotionAudioPool =
        await FlameAudio.createPool('explosion.wav', maxPlayers: 2);
    // components
    add(parallax);
    add(joystick);
    add(ShootButton());

    await add(FlameMultiBlocProvider(
      providers: [
        FlameBlocProvider<CountCubit, CountState>(
          create: () => CountCubit(),
        ),
      ],
      children: [
        player,
        enemySpawner,
        enemyUfoSpawner,
        asteroidSpawner,
        countComponent,
        lifeIndicator,
      ],
    ));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    enemySpawner.area = Rectangle.fromLTWH(0, -500, size.x, -Enemy.enemySize);
    enemyUfoSpawner.area =
        Rectangle.fromLTWH(0, -500, size.x, -EnemyUfo.enemySize);
    asteroidSpawner.area =
        Rectangle.fromLTWH(0, -500, size.x, -Asteroid.enemySize);
  }

  @override
  void onDispose() {
    super.onDispose();
    shootAudioPool.dispose();
    explotionAudioPool.dispose();
    FlameAudio.bgm.dispose();
  }
}
