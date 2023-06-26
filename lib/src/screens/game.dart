import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/colors.dart';
import '../bloc/game_cubit.dart';
import '../bloc/game_state.dart';

class Game extends StatelessWidget {
  const Game({super.key, required this.title});

  final String title;

  void _showWinDialog({
    required BuildContext context,
    required GameCubit cubit,
    required String winner,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(' $winner  venceu!'),
          actions: [
            TextButton(
              child: const Text("Jogar novamente"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _showDrawDialog({
    required BuildContext context,
    required GameCubit cubit,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Empate!'),
          actions: [
            TextButton(
              child: const Text("Jogar novamente"),
              onPressed: () {
                cubit.resetBoard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return BlocConsumer<GameCubit, GameState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.status == GameStatus.hasWinner && state.gameWinner != null) {
          _showWinDialog(
            context: context,
            cubit: cubit,
            winner: state.gameWinner!,
          );
        }

        if (state.status == GameStatus.hasDraw) {
          _showDrawDialog(
            context: context,
            cubit: cubit,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CoreColors.primaryColor,
          appBar: AppBar(
            title: Text(title),
            backgroundColor: CoreColors.primaryColor,
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  padding: const EdgeInsets.all(16.0),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: List.generate(
                    9,
                    (index) => InkWell(
                      onTap: () => cubit.makePlay(
                        index: index,
                        playerTurn: state.playerTurn,
                      ),
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(
                            Radius.circular(13),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            state.board[index],
                            style: TextStyle(
                              fontSize: 70,
                              color: CoreColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Agora é a vez do ${state.playerTurn} de jogar',
                style: const TextStyle(fontSize: 18),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              Column(
                children: [
                  Text('X venceu ${state.xPlayerScore} vez(es)'),
                  Text('O venceu ${state.oPlayerScore} vez(es)'),
                  Text('Empatou ${state.drawGameScore} vez(es)'),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              cubit.resetBoard();
              cubit.resetScore();
            },
            label: const Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(Icons.replay_circle_filled, color: Colors.white),
            backgroundColor: Colors.pink,
          ),
        );
      },
    );
  }
}
