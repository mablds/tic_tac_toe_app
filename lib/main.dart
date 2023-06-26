import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_app/src/screens/game.dart';

import 'src/screens/bloc/game_cubit.dart';
import 'src/screens/constants/game_constants.dart';

void main() => runApp(const TicTacToe());

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: GameConstants.title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => GameCubit(),
        child: Game(
          title: GameConstants.title,
        ),
      ),
    );
  }
}
