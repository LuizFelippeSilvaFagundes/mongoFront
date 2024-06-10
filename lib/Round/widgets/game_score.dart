import 'dart:async';
import 'package:flutter/material.dart';
import 'package:consumir/Round/constants.dart';
import 'package:consumir/Round/controllers/game_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class GameScore extends StatefulWidget {
  final Modo modo;
  const GameScore({Key? key, required this.modo}) : super(key: key);

  @override
  _GameScoreState createState() => _GameScoreState();
}

class _GameScoreState extends State<GameScore> {
  late Stream<int> _timerStream;
  late StreamController<int> _timerStreamController;
  late Timer _timer;
  int _secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
    _timerStreamController = StreamController<int>();
    _timerStream = _timerStreamController.stream;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final controller = context.read<GameController>();
      if (controller.venceu || controller.perdeu) {
        _timer.cancel();
      } else {
        _secondsElapsed++;
        _timerStreamController.add(_secondsElapsed);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timerStreamController.close();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.modo == Modo.round6 ? Icons.my_location : Icons.touch_app_rounded),
            const SizedBox(width: 10),
            Observer(
              builder: (_) => Text(controller.score.toString(), style: const TextStyle(fontSize: 25)),
            ),
            const SizedBox(width: 10),
            StreamBuilder<int>(
              stream: _timerStream,
              builder: (context, snapshot) {
                final time = snapshot.data ?? 0;
                return Text(
                  _formatTime(time),
                  style: const TextStyle(fontSize: 25),
                );
              },
            ),
          ],
        ),
        Image.asset('im/cards_normalz.png', width: 38, height: 60),
        TextButton(
          child: const Text('Sair', style: TextStyle(fontSize: 18)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
