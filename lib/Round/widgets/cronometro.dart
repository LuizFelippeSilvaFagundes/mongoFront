// lib/cronometro.dart

import 'dart:async';
import 'package:flutter/material.dart';

class Cronometro extends StatefulWidget {
  final bool start;

  const Cronometro({Key? key, this.start = false}) : super(key: key);

  @override
  _CronometroState createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro> {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    if (widget.start) {
      _startTimer();
    }
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void start() {
    if (!_isRunning) {
      _startTimer();
    }
  }

  void reset() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');

    return Text(
      'Tempo: $minutes:$seconds',
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}
