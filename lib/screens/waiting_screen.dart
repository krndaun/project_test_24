import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Waiting')),
      body: Center(
        child: Text('Waiting for account approval...'),
      ),
    );
  }
}
