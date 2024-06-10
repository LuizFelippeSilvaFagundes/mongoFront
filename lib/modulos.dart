import 'package:flutter/material.dart';

class ChooseRegistrationTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Container(
                width: double.infinity,
                child: Image.asset(
                  "im/logo_vi.png", // caminho da imagem da logo
                  fit: BoxFit.fitWidth, // ajusta a imagem de acordo com o tamanho disponível
                ),
              ),
              SizedBox(height: 40), // Espaçamento entre a logo e os botões
              // Botões
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_user');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Define a cor do botão
                    ),
                    child: Text(
                      'Sou Paciente',
                      style: TextStyle(
                        fontSize: 25, // Tamanho da fonte aumentado para 25
                        color: Colors.white, // Define a cor do texto
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_psychologist');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Define a cor do botão
                    ),
                    child: Text(
                      'Sou Psicólogo',
                      style: TextStyle(
                        fontSize: 25, // Tamanho da fonte aumentado para 25
                        color: Colors.white, // Define a cor do texto
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
