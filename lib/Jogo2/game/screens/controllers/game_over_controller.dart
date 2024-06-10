import 'package:flutter/material.dart';

Future<void> gameOver(context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      children: [
        Container(
          color: Colors.transparent,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "GAME OVER",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Colors.white12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
