import 'dart:math';

import 'package:flutter/material.dart';
import 'package:consumir/Round/constants.dart';
import 'package:consumir/Round/controllers/game_controller.dart';
import 'package:consumir/Round/game_settings.dart';
import 'package:consumir/Round/models/game_opcao.dart';

import 'package:consumir/Round/models/game_play.dart';
import 'package:consumir/Round/theme.dart';
import 'package:consumir/Round/widgets/card_game.dart';
import 'package:consumir/Round/widgets/feedback_game.dart';
import 'package:consumir/Round/widgets/game_score.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../models/game_opcao.dart';

class GamePage extends StatelessWidget {
  final GamePlay gamePlay;

  const GamePage({Key? key, required this.gamePlay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GameScore(modo: gamePlay.modo),
      ),
      body: Observer(
        builder: (_) {
          if (controller.venceu) {
            return const FeedbackGame(resultado: Resultado.aprovado);
          } else if (controller.perdeu) {
            return const FeedbackGame(resultado: Resultado.eliminado);
          } else {
            return Center(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: GameSettings.gameBoardAxisCount(gamePlay.nivel),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: const EdgeInsets.all(24),
                children: controller.gameCards
                    .map(
                      (GameOpcao go) => CardGame(modo: gamePlay.modo, gameOpcao: go),
                )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
