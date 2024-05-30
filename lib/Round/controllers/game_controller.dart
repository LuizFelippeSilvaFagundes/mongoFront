import 'dart:async';

import 'package:consumir/Round/constants.dart';
import 'package:consumir/Round/game_settings.dart';
import 'package:consumir/Round/models/game_opcao.dart';
import 'package:consumir/Round/models/game_play.dart';
import 'package:consumir/Round/repositories/recordes_repository.dart';
import 'package:mobx/mobx.dart';

part 'game_controller.g.dart';

class GameController = GameControllerBase with _$GameController;

abstract class GameControllerBase with Store {
  @observable
  List<GameOpcao> gameCards = [];
  @observable
  int score = 0;
  @observable
  bool venceu = false;
  @observable
  bool perdeu = false;
  @observable
  int elapsedTime = 0;  // Tempo decorrido em segundos

  late GamePlay _gamePlay;
  List<GameOpcao> _escolha = [];
  List<Function> _escolhaCallback = [];
  int _acertos = 0;
  int _numPares = 0;
  RecordesRepository recordesRepository;
  Timer? _timer;  // Timer para o cronômetro

  @computed
  bool get jogadaCompleta => (_escolha.length == 2);

  GameControllerBase({required this.recordesRepository}) {
    reaction((_) => venceu == true, (bool ganhou) {
      if (ganhou) {
        _stopTimer();
        recordesRepository.updateRecordes(gamePlay: _gamePlay, score: score, elapsedTime: elapsedTime);
      }
    });
  }

  @action
  startGame({required GamePlay gamePlay}) {
    _gamePlay = gamePlay;
    _acertos = 0;
    _numPares = (_gamePlay.nivel / 2).round();
    venceu = false;
    perdeu = false;
    _resetScore();
    _generateCards();
    _startTimer();
  }

  @action
  _resetScore() {
    _gamePlay.modo == Modo.normal ? score = 0 : score = _gamePlay.nivel;
  }

  @action
  _generateCards() {
    List<int> cardOpcoes = GameSettings.cardOpcoes.sublist(0)..shuffle();
    cardOpcoes = cardOpcoes.sublist(0, _numPares);
    gameCards = [...cardOpcoes, ...cardOpcoes]
        .map((opcao) => GameOpcao(opcao: opcao, matched: false, selected: false))
        .toList();
    gameCards.shuffle();
  }

  @action
  escolher(GameOpcao opcao, Function resetCard) async {
    opcao.selected = true;
    _escolha.add(opcao);
    _escolhaCallback.add(resetCard);
    await _compararEscolhas();
  }

  @action
  _compararEscolhas() async {
    if (jogadaCompleta) {
      if (_escolha[0].opcao == _escolha[1].opcao) {
        _acertos++;
        _escolha[0].matched = true;
        _escolha[1].matched = true;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          for (var i in [0, 1]) {
            _escolha[i].selected = false;
            _escolhaCallback[i]();
          }
        });
      }

      _resetJogada();
      _updateScore();
      _checkGameResult();
    }
  }

  @action
  _checkGameResult() async {
    bool allMatched = _acertos == _numPares;
    if (_gamePlay.modo == Modo.normal) {
      await _checkResultModoNormal(allMatched);
    } else {
      await _checkResultModoRound6(allMatched);
    }
  }

  @action
  _checkResultModoNormal(bool allMatched) async {
    await Future.delayed(const Duration(seconds: 1), () => venceu = allMatched);
  }

  @action
  _checkResultModoRound6(bool allMatched) async {
    if (_chancesAcabaram()) {
      await Future.delayed(const Duration(milliseconds: 400), () => perdeu = true);
    }
    if (allMatched && score >= 0) {
      await Future.delayed(const Duration(seconds: 1), () => venceu = allMatched);
    }
  }

  @action
  _chancesAcabaram() {
    return score < _numPares - _acertos;
  }

  @action
  _resetJogada() {
    _escolha = [];
    _escolhaCallback = [];
  }

  @action
  _updateScore() {
    _gamePlay.modo == Modo.normal ? score++ : score--;
  }

  @action
  restartGame() {
    startGame(gamePlay: _gamePlay);
  }

  @action
  nextLevel() {
    int nivelIndex = 0;

    if (_gamePlay.nivel != GameSettings.niveis.last) {
      nivelIndex = GameSettings.niveis.indexOf(_gamePlay.nivel) + 1;
    }

    _gamePlay.nivel = GameSettings.niveis[nivelIndex];
    startGame(gamePlay: _gamePlay);
  }

  // Métodos para controlar o cronômetro
  void _startTimer() {
    _timer?.cancel();
    elapsedTime = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedTime++;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }
}
