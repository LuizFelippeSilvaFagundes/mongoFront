import 'package:flutter/material.dart';

class ChooseRegistrationTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_user');
              },
              child: Text('Paciente'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_psychologist');
              },
              child: Text('Psicólogo'),
            ),
          ],
        ),
      ),
    );
  }
}
