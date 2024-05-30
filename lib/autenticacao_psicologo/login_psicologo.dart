import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:consumir/autenticacao_psicologo/registro_psicologo.dart'; // Importe a tela de registro de psicólogo

class LoginPsychologistScreen extends StatefulWidget {
  @override
  _LoginPsychologistScreenState createState() => _LoginPsychologistScreenState();
}

class _LoginPsychologistScreenState extends State<LoginPsychologistScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/login_psychologist'), // Altere para a URL do seu servidor
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login bem-sucedido')));
        // Você pode armazenar o token e navegar para outra tela
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha no login')));
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao fazer login')));
    }
  }

  void _navigateToRegisterPsychologistScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPsychologistScreen()), // Navegar para a tela de registro de psicólogo
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login de Psicólogo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: _navigateToRegisterPsychologistScreen,
                child: Text("Ainda não é cadastrado como psicólogo?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
