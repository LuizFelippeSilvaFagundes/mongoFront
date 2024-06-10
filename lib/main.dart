import 'package:consumir/Jogo2/game/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:consumir/autenticacao_usuario/login_screen.dart';
import 'package:consumir/autenticacao_usuario/register.dart';
import 'package:consumir/autenticacao_psicologo/login_psicologo.dart';
import 'package:consumir/autenticacao_psicologo/registro_psicologo.dart';
import 'package:consumir/modulos.dart'; // Importe a tela de escolha de tipo de registro
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:consumir/Round/controllers/game_controller.dart';
import 'package:consumir/Round/pages/game_page.dart'; // Importe a página do jogo
import 'package:consumir/Round/repositories/recordes_repository.dart';
import 'package:consumir/Round/models/game_play.dart'; // Importação do GamePlay
import 'package:consumir/Round/constants.dart'; // Importação das constantes Modo e Resultado
import 'package:consumir/Round/pages/home_page.dart';
import 'package:consumir/Round/pages/homeScreen.dart';


void main() async {
  await Hive.initFlutter();

  runApp(MultiProvider(
    providers: [
      Provider<RecordesRepository>(create: (_) => RecordesRepository()),
      ProxyProvider<RecordesRepository, GameController>(
        update: (_, repo, __) => GameController(recordesRepository: repo),
      ),
    ],
    child: const App(),
  ));

}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth & Memory Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/choose_registration_type', // Defina a rota inicial como a tela de escolha do tipo de registro
      routes: {

        '/homeScreen': (context) => HomeScreen(),
        '/home_page' : (context) => HomePage(),
        '/choose_registration_type': (context) => ChooseRegistrationTypeScreen(), // Rota para a tela de escolha do tipo de registro
        '/login_user': (context) => LoginScreen(), // Rota para o login de usuário comum,
        '/register_user': (context) => RegisterScreen(), // Rota para o registro de usuário comum
        '/login_psychologist': (context) => LoginPsychologistScreen(), // Rota para o login de psicólogo
        '/register_psychologist': (context) => RegisterPsychologistScreen(), // Rota para o registro de psicólogo
        '/game_page': (context) => GamePage(gamePlay: GamePlay(modo: Modo.normal, nivel: 1)),// Rota para a tela do jogo da memória
      },
    );
  }
}
