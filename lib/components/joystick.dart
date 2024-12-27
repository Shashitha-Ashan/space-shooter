import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class SpaceShipGameJoystick extends JoystickComponent {
  SpaceShipGameJoystick()
      : super(
            knob: CircleComponent(
              radius: 40,
              paint: Paint()..color = const Color.fromARGB(255, 71, 71, 71),
            ),
            background: CircleComponent(
              radius: 60,
              paint: Paint()..color = const Color.fromARGB(20, 255, 255, 255),
            ),
            margin: const EdgeInsets.only(left: 30, bottom: 20),
            priority: 1);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    size = Vector2(120, 120);
  }
}
