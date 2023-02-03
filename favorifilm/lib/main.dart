import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffd7e0ff),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[800],
          title: Text('INTERSTELLAR'),
        ),
        body: Center(child: Image.asset('images/photo1.jpeg')),
      ),
    ),
  );
}
