import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    GameState? initialState,
  }) : super(initialState ?? const GameState());

  void makePlay({required int index, required String playerTurn}) {
    if (state.board[index] != '') return;

    List<String> actualBoard = List.from(state.board);
    actualBoard[index] = playerTurn;

    if (hasWinner()) {
      emit(state.copyWith(
        status: GameStatus.hasWinner,
        gameWinner: playerTurn,
        playerTurn: revertPlayerTurn(actualPlayer: playerTurn),
      ));
      resetBoard();
    } else if (hasDraw()) {
      emit(state.copyWith(
        status: GameStatus.hasDraw,
      ));
      resetBoard();
    } else {
      return emit(state.copyWith(
        playerTurn: revertPlayerTurn(actualPlayer: playerTurn),
        board: actualBoard,
      ));
    }
  }

  String revertPlayerTurn({required String actualPlayer}) =>
      actualPlayer == 'X' ? 'O' : 'X';

  void resetBoard() => emit(
        state.copyWith(
          board: List.filled(9, '', growable: false),
        ),
      );

  bool hasWinner() {
    if (state.board[0] != '' &&
            state.board[0] == state.board[1] &&
            state.board[0] == state.board[2] ||
        state.board[3] != '' &&
            state.board[3] == state.board[4] &&
            state.board[3] == state.board[5] ||
        state.board[6] != '' &&
            state.board[6] == state.board[7] &&
            state.board[6] == state.board[8] ||
        state.board[0] != '' &&
            state.board[0] == state.board[4] &&
            state.board[0] == state.board[8] ||
        state.board[2] != '' &&
            state.board[2] == state.board[6] &&
            state.board[2] == state.board[4] ||
        state.board[0] != '' &&
            state.board[0] == state.board[3] &&
            state.board[0] == state.board[6] ||
        state.board[1] != '' &&
            state.board[1] == state.board[4] &&
            state.board[1] == state.board[7] ||
        state.board[2] != '' &&
            state.board[2] == state.board[5] &&
            state.board[2] == state.board[8]) {
      return true;
    }
    return false;
  }

  void increaseWinScore({required String winner}) {
    if (winner == 'X') {
      return emit(state.copyWith(xPlayerScore: state.xPlayerScore + 1));
    } else {
      return emit(state.copyWith(xPlayerScore: state.oPlayerScore + 1));
    }
  }

  void increaseDrawScore() =>
      emit(state.copyWith(drawGameScore: state.drawGameScore + 1));

  void resetScore() => emit(
        state.copyWith(xPlayerScore: 0, oPlayerScore: 0, drawGameScore: 0),
      );

  bool hasDraw() => !state.board.contains('');
}
