import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:snake/screens/game_over.dart';
import 'package:snake/screens/start_page.dart';
import 'package:snake/socket/websocket.dart';

import 'space_ship_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final GameSocket gameSocket = GameSocket();
  // gameSocket.connect();

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(GameWidget(
    game: SpaceShipGame()..pauseEngine(),
    overlayBuilderMap: {
      'GameOver': (_, game) => GameOver(game: game as SpaceShipGame),
      'Home': (_, game) => StartPage(game: game as SpaceShipGame),
    },
    initialActiveOverlays: const ['Home'],
  ));
}
