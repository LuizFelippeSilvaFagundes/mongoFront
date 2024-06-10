import 'package:flutter/material.dart';
import 'package:consumir/Round/constants.dart';
import 'package:consumir/Round/controllers/game_controller.dart';
import 'package:consumir/Round/models/game_play.dart';
import 'package:consumir/Round/pages/game_page.dart';
import 'package:consumir/Round/theme.dart';
import 'package:provider/provider.dart';

class CardNivel extends StatelessWidget {
  final GamePlay gamePlay;

  const CardNivel({Key? key, required this.gamePlay}) : super(key: key);

  void startGame(BuildContext context) {
    context.read<GameController>().startGame(gamePlay: gamePlay);

    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => GamePage(gamePlay: gamePlay),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => startGame(context),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 20), // Espaçamento adicionado na parte superior
        decoration: BoxDecoration(
          border: Border.all(
            color: gamePlay.modo == Modo.normal ? Colors.red : BrainTheme.color,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            // Imagem de fundo
            Positioned.fill(
              child: Image.asset(
                'im/card.png',
                fit: BoxFit.cover,
              ),
            ),
            // Número do card
            Center(
              child: Text(
                gamePlay.nivel.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
