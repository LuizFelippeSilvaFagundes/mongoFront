import 'package:flutter/material.dart';
import 'package:consumir/Round/theme.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Image.asset('im/cards_normalz.png', width: 80, height: 125),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: RichText(
            text: TextSpan(
              text: 'Jogo da ',
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30),
              children: const [
                TextSpan(
                  text: 'Memoria',
                  style: TextStyle(color: BrainTheme.color),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
