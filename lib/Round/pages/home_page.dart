import 'package:flutter/material.dart';
import 'package:consumir/Round/constants.dart';
import 'package:consumir/Round/pages/nivel_page.dart';
import 'package:consumir/Round/theme.dart';
import 'package:consumir/Round/widgets/logo.dart';
import 'package:consumir/Round/widgets/recordes.dart';
import 'package:consumir/Round/widgets/start_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  selecionarNivel(Modo modo, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NivelPage(modo: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            StartButton(
              title: 'Modo Normal',
              color: BrainTheme.color,
              action: () => selecionarNivel(Modo.normal, context),
            ),
            StartButton(
              title: 'Modo Dificil',
              color: BrainTheme.color,
              action: () => selecionarNivel(Modo.round6, context),
            ),
            const SizedBox(height: 60),
            const Recordes(),
          ],
        ),
      ),
    );
  }
}
