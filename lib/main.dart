import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _usuarios = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  Future<void> fetchUsuarios() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.18.4:3000/usuarios'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Restante do código...
    } catch (e) {
      print('Error fetching usuarios: $e');
      setState(() {
        _errorMessage = 'Falha ao carregar os dados: $e';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : _usuarios.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _usuarios.length,
        itemBuilder: (context, index) {
          final usuario = _usuarios[index];
          return ListTile(
            title: Text(usuario['name'] ?? 'Sem nome'),
            subtitle: Text(usuario['email'] ?? 'Sem email'),
          );
        },
      ),
    );
  }
}
