import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  final Function() changeScreen;

  Future<void> timeChange() async {
    await Future.delayed(Duration(seconds: 1), changeScreen);
  }

  InitialScreen({required this.changeScreen}); // Alteração feita aqui
  @override
  Widget build(BuildContext context) {
    timeChange();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
              'im/background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'im/logo.png',
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
