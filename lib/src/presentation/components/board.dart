import 'dart:developer';

import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: List.generate(
        9,
        (index) => InkWell(
          onTap: () => log(index.toString()),
          child: Container(
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
      ),
    );
  }
}
