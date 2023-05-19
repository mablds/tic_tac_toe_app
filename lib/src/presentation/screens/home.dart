import 'package:flutter/material.dart';

import '../components/board.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 97, 154, 252),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 97, 154, 252),
      ),
      body: const Board(),
    );
  }
}
