import 'package:consumir/Jogo2/game/screens/gamofled.dart';
import 'package:consumir/Round/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:consumir/Jogo2/game/screens/HomeScreen.dart';

class GameSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seleção de Jogo',
          style: TextStyle(color: Colors.white), // Definindo a cor do texto do título
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.blue, // Definindo a cor de fundo do Scaffold
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Escolha um Jogo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navegar para a tela do Jogo da Memória
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Cor de fundo do botão
                ),
                child: Text(
                  'Jogo da Memoria',
                  style: TextStyle(
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Cor de fundo do botão
                ),
                child: Text(
                  'Attention Game',
                  style: TextStyle(
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
