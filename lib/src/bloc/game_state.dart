import 'package:equatable/equatable.dart';

enum GameStatus { initial, inProgress, hasWinner, hasDraw, error }

class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.initial,
    this.playerTurn = 'x',
    this.drawGameScore = 0,
    this.oPlayerScore = 0,
    this.xPlayerScore = 0,
    this.board = const ['', '', '', '', '', '', '', '', ''],
    this.gameWinner,
  });

  final GameStatus status;
  final String playerTurn;
  final int drawGameScore;
  final int oPlayerScore;
  final int xPlayerScore;
  final List<String> board;
  final String? gameWinner;

  GameState copyWith({
    GameStatus? status,
    String? playerTurn,
    int? drawGameScore,
    int? oPlayerScore,
    int? xPlayerScore,
    String? gameWinner,
    List<String>? board,
  }) {
    return GameState(
      status: status ?? this.status,
      playerTurn: playerTurn ?? this.playerTurn,
      gameWinner: gameWinner ?? this.gameWinner,
      drawGameScore: drawGameScore ?? this.drawGameScore,
      xPlayerScore: xPlayerScore ?? this.xPlayerScore,
      oPlayerScore: oPlayerScore ?? this.oPlayerScore,
      board: board ?? this.board,
    );
  }

  @override
  List<Object?> get props => <Object?>[];
}
