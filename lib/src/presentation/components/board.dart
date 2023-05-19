import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: List.generate(
        9,
        (index) => Container(
          height: 8,
          width: 8,
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            ),
          ),
        ),
      ),
    );
  }
}
