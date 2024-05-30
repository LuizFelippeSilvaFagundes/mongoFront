import 'package:flutter/material.dart';

class PsychologistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Psicólogo'),
      ),
      body: Center(
        child: Text(
          'Psicólogo',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
