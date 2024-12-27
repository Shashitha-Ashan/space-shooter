import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:snake/bloc/count/count_cubit.dart';
import 'package:snake/components/collidable/astroid.dart';
import 'package:snake/components/count_component.dart';
import 'package:snake/components/collidable/enemy.dart';
import 'package:snake/components/collidable/enemy_UFO.dart';
import 'package:snake/components/indicators/life_indicator.dart';
import 'package:snake/components/joystick.dart';
import 'package:snake/components/parralax_bkg.dart';
import 'package:snake/components/shoot_button.dart';

import 'package:snake/game_world.dart';
import 'package:snake/player.dart';

class SpaceShipGame extends FlameGame with HasCollisionDetection {
  SpaceShipGame() : super(world: SpaceWorld());

  final SpaceShipGameJoystick joystick = SpaceShipGameJoystick();
  final ParralaxBackground parallax = ParralaxBackground();
  final Player player = Player();
  final LifeIndicator lifeIndicator = LifeIndicator();
  @override
  Future<void> onLoad() async {
    await super.onLoad();
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
        SpawnComponent(
          factory: (index) {
            return EnemyUfo();
          },
          period: 3,
          area: Rectangle.fromLTWH(0, -500, size.x, -EnemyUfo.enemySize),
        ),
        SpawnComponent(
          factory: (index) {
            return Enemy();
          },
          period: 1,
          area: Rectangle.fromLTWH(0, -500, size.x, -Enemy.enemySize),
        ),
        SpawnComponent(
          factory: (index) {
            return Asteroid();
          },
          period: 1,
          area: Rectangle.fromLTWH(0, -500, size.x, -Asteroid.enemySize),
        ),
        CountComponent(),
        lifeIndicator
      ],
    ));
  }

  void reset() {}

  // @override
  // void update(double dt) {
  //   if (bloc.state.gameStatus == GameStatus.over) {
  //     overlays.add("Game over");
  //   }
  //   super.update(dt);
  // }
}
