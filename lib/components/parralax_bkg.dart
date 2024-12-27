import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import '../space_ship_game.dart';

class ParralaxBackground extends ParallaxComponent<SpaceShipGame> {
  ParralaxBackground() : super();
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    parallax = await game.loadParallax(
      [
        ParallaxImageData('backgroung/bkg.png'),
      ],
      baseVelocity: Vector2(0, -20),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );
  }
}
