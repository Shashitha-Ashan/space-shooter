import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends PositionComponent with TapCallbacks {
  ButtonComponent({
    required this.onTap,
    required this.btnPosition,
    required this.btnSize,
    required this.spritePath,
  }) : super(size: btnSize, position: btnPosition, anchor: Anchor.center);

  final VoidCallback onTap;
  final Vector2 btnSize;
  final Vector2 btnPosition;
  final String spritePath;

  late Sprite sprite;
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(spritePath);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect().translate(position.x, position.y),
        Paint()..color = const Color(0x88FF0000));
    sprite.render(canvas, size: size);
  }

  @override
  void onTapDown(TapDownEvent event) {
    print("Button tapped");
    onTap();
    super.onTapDown(event);
  }
}
