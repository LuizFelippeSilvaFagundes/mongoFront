import 'package:flutter/material.dart';

class ChooseRegistrationTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha o Tipo de Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_user');
              },
              child: Text('Cadastro como Usuário'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_psychologist');
              },
              child: Text('Cadastro como Psicólogo'),
            ),
          ],
        ),
      ),
    );
  }
}
