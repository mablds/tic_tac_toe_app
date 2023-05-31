import 'dart:developer';

import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> board = List.filled(9, '', growable: false);
  String playerTurn = 'X';
  int xPlayerScore = 0;
  int oPlayerScore = 0;
  int drawGameScore = 0;

  void _makePlay({
    required int index,
    required String player,
  }) {
    setState(() {
      if (board[index] != '') return;

      board[index] = player;

      if (_hasWinner(player: player)) {
        _showWinDialog(winner: player);
        _resetBoard();
      } else if (_hasDrawCondition()) {
        _showDrawDialog();
        _resetBoard();
      } else {
        _changePlayerTurn(lastPlayer: player);
      }
    });
  }

  void _changePlayerTurn({required String lastPlayer}) {
    playerTurn = lastPlayer == 'X' ? 'O' : 'X';
  }

  void _resetBoard() {
    setState(() {
      board = List.filled(9, '');
    });
  }

  void _resetScore() {
    xPlayerScore = 0;
    oPlayerScore = 0;
  }

  bool _hasWinner({required String player}) {
    if (board[0] != '' && board[0] == board[1] && board[0] == board[2] ||
        board[3] != '' && board[3] == board[4] && board[3] == board[5] ||
        board[6] != '' && board[6] == board[7] && board[6] == board[8] ||
        board[0] != '' && board[0] == board[4] && board[0] == board[8] ||
        board[2] != '' && board[2] == board[6] && board[2] == board[4] ||
        board[0] != '' && board[0] == board[3] && board[0] == board[6] ||
        board[1] != '' && board[1] == board[4] && board[1] == board[7] ||
        board[2] != '' && board[2] == board[5] && board[2] == board[8]) {
      return true;
    }

    return false;
  }

  bool _hasDrawCondition() => !board.contains('');

  void _showWinDialog({required String winner}) {
    if (winner == 'X') {
      xPlayerScore = xPlayerScore + 1;
    } else {
      oPlayerScore = oPlayerScore + 1;
    }

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

  void _showDrawDialog() {
    drawGameScore = drawGameScore + 1;
    log('drawGameScore: $drawGameScore');

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
                _resetBoard();
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
    return Scaffold(
      backgroundColor: CoreColors.primaryColor,
      appBar: AppBar(
        title: Text(widget.title),
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
                  onTap: () => _makePlay(
                    index: index,
                    player: playerTurn,
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
                        board[index],
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
            'Agora é a vez do $playerTurn de jogar',
            style: const TextStyle(fontSize: 18),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          Text('X venceu $xPlayerScore vez(es)'),
          Text('O venceu $oPlayerScore vez(es)'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _resetBoard();
          _resetScore();
        },
        label: const Text(
          'Reset',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.replay_circle_filled, color: Colors.white),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
