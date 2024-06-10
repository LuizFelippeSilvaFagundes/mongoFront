import 'package:consumir/Round/constants.dart';
import 'package:consumir/Round/models/game_play.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

part 'recordes_repository.g.dart';

class RecordesRepository = RecordesRepositoryBase with _$RecordesRepository;

abstract class RecordesRepositoryBase with Store {
  late final Box _recordes;
  late String _userId;
  late String _email;

  RecordesRepositoryBase() {
    _initRepository();
  }

  _initRepository() async {
    await _initDatabase();
    await _initSharedPreferences();
    await loadRecordes();
  }

  _initDatabase() async {
    _recordes = await Hive.openBox('gameRecordes3');
  }

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('user_id') ?? '';
    _email = prefs.getString('email') ?? '';
  }

  @action
  loadRecordes() {
    recordesNormal = _recordes.get(Modo.normal.toString()) ?? {};
    recordesRound6 = _recordes.get(Modo.round6.toString()) ?? {};
  }

  Future<void> _sendRecordToBackend(String tempo, String quantidadeToques, String nivel) async {
    const String url = 'http://localhost:1000/add_record';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          '_id_user': _userId, // Inclua o ID do usuário
          'email': _email, // Inclua o email do usuário
          'tempo': tempo,
          'quantidadeToques': quantidadeToques,
          'nivel': nivel, // Inclua o nível
        }),
      );

      if (response.statusCode == 201) {
        print('Recorde enviado com sucesso.');
      } else {
        print('Falha ao enviar o recorde. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao enviar o recorde: $e');
    }
  }

  @observable
  Map recordesRound6 = {};
  @observable
  Map recordesNormal = {};

  @action
  updateRecordes({required GamePlay gamePlay, required int score, required int elapsedTime}) {
    final key = gamePlay.modo.toString();
    final level = gamePlay.nivel.toString(); // Adicione o nível

    // Obter o ID e email do usuário dos SharedPreferences
    _sendRecordToBackend(elapsedTime.toString(), score.toString(), level); // Inclua o nível

    if (gamePlay.modo == Modo.normal &&
        (recordesNormal[gamePlay.nivel] == null || score < recordesNormal[gamePlay.nivel])) {
      recordesNormal[gamePlay.nivel] = score;
      _recordes.put(key, recordesNormal);
    } else if (gamePlay.modo == Modo.round6 &&
        (recordesRound6[gamePlay.nivel] == null || score > recordesRound6[gamePlay.nivel])) {
      recordesRound6[gamePlay.nivel] = score;
      _recordes.put(key, recordesRound6);
    }
  }
}
