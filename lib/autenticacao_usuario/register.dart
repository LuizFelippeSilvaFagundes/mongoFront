import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart'; // Importando a tela de login

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _psychologistEmailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Future<void> _register() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String psychologistEmail = _psychologistEmailController.text;
    final String userName = _userNameController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/register'), // Altere para a URL do seu servidor
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'psychologistEmail': psychologistEmail,
          'userName': userName,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registrado com sucesso')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()), // Navegar para a tela de login
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha no registro')));
      }
    } catch (e) {
      print('Erro ao registrar: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao registrar')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
              TextFormField(
                controller: _psychologistEmailController,
                decoration: InputDecoration(labelText: 'Email do Psicólogo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email do seu psicólogo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'Nome do Usuário'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _register();
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
