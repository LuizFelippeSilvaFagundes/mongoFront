import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPsychologistScreen extends StatefulWidget {
  @override
  _RegisterPsychologistScreenState createState() => _RegisterPsychologistScreenState();
}

class _RegisterPsychologistScreenState extends State<RegisterPsychologistScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cipController = TextEditingController();

  Future<void> _register() async {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    final String email = _emailController.text;
    final String cip = _cipController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/register_psychologist'), // Altere para a URL do seu servidor
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'password': password,
          'email': email,
          'cip': cip,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registrado com sucesso')));
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
        title: Text('Registro de Psicólogo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
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
                controller: _cipController,
                decoration: InputDecoration(labelText: 'CIP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu CIP';
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
