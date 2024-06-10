import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  final TextEditingController _emailController = TextEditingController();
  List<dynamic> _userRecords = [];

  Future<Map<String, dynamic>> _fetchRecordsByEmail(String email) async {
    final response = await http.get(
      Uri.parse('http://localhost:1000/user_records_by_email/$email'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar registros');
    }
  }

  void _searchRecords() async {
    final email = _emailController.text;
    try {
      final data = await _fetchRecordsByEmail(email);
      setState(() {
        _userRecords = [data]; // Coloca o objeto dentro de uma lista
      });
    } catch (e) {
      print('Erro ao buscar registros: $e');
      // Trate o erro conforme necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue, // Define a cor de fundo do Scaffold como azul
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple), // Define a cor de fundo do botão como roxo
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Define a cor do texto do botão como branco
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple, // Define a cor de fundo da appBar como roxo
          titleTextStyle: TextStyle(
            color: Colors.white, // Define a cor do texto do título da appBar como branco
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white), // Define a cor do texto do título da AppBar como branco
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8, // Definindo a largura do Container
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('im/login.png'), // Adicione sua logo aqui
                  SizedBox(height: 20),
                  Text(
                    'Pesquisar registros por email:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Digite o email do psicólogo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _searchRecords,
                    child: Text('Pesquisar'),
                  ),
                  SizedBox(height: 20),
                  if (_userRecords.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: _userRecords.length,
                        itemBuilder: (context, index) {
                          final record = _userRecords[index];
                          final user = record['user'];
                          final userRecords = record['records'] ?? [];

                          if (user == null || user['email'] == null) {
                            return ListTile(
                              title: Text('Usuário ou email não encontrado'),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Usuário: ${user['email']}', // Exibe o email do usuário
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: userRecords.length,
                                itemBuilder: (context, index) {
                                  final userRecord = userRecords[index];
                                  return ListTile(
                                    title: Text('Tempo: ${userRecord['tempo']}'),
                                    subtitle: Text(
                                        'Quantidade de Toques: ${userRecord['quantidadeToques']}'),
                                    // Adicione mais informações se necessário
                                  );
                                },
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(HomeScreen1());
}
