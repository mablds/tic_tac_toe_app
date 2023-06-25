import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_app/src/screens/game.dart';

import 'src/bloc/game_cubit.dart';

const _appTitle = 'Jogo da Velha';

void main() => runApp(const TicTacToe());

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (_) => GameCubit(),
          child: const Game(
            title: _appTitle,
          ),
        ));
  }
}
