import 'package:flutter/material.dart';
import 'package:snake/space_ship_game.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key, required this.game});
  final SpaceShipGame game;

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    game.resumeEngine();
                    game.overlays.remove('Home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: blackTextColor,
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  game.resumeEngine();
                  game.overlays.remove('Home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: whiteTextColor,
                ),
                child: const Text(
                  "Join",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: blackTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  game.resumeEngine();
                  game.overlays.remove('Home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: whiteTextColor,
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: blackTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
