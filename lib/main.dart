import 'package:flutter/material.dart';
import 'package:consumir/autenticacao_usuario/login_screen.dart';
import 'package:consumir/autenticacao_usuario/register.dart';
import 'package:consumir/autenticacao_psicologo/login_psicologo.dart';
import 'package:consumir/autenticacao_psicologo/registro_psicologo.dart';
import 'package:consumir/modulos.dart'; // Importe a tela de escolha de tipo de registro

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/choose_registration_type', // Defina a rota inicial como a tela de escolha do tipo de registro
      routes: {
        '/choose_registration_type': (context) => ChooseRegistrationTypeScreen(), // Rota para a tela de escolha do tipo de registro
        '/login_user': (context) => LoginScreen(), // Rota para o login de usuário comum
        '/register_user': (context) => RegisterScreen(), // Rota para o registro de usuário comum
        '/login_psychologist': (context) => LoginPsychologistScreen(), // Rota para o login de psicólogo
        '/register_psychologist': (context) => RegisterPsychologistScreen(), // Rota para o registro de psicólogo
      },
    );
  }
}
