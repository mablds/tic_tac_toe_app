import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    GameState? initialState,
  }) : super(initialState ?? const GameState());

  Future<void> makePlay({
    required int index,
    required String playerTurn,
  }) async {
    if (state.board[index] != '') return;

    List<String> actualBoard = List.from(state.board);
    actualBoard[index] = playerTurn;

    emit(state.copyWith(board: actualBoard));

    if (_hasWinner(board: actualBoard)) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => increaseWinScore(playerTurn: playerTurn),
      );
    } else if (_hasDraw(board: actualBoard)) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => increaseDrawScore(),
      );
    } else {
      emit(state.copyWith(
        playerTurn: revertPlayerTurn(actualPlayer: playerTurn),
        status: GameStatus.inProgress,
        board: actualBoard,
      ));
    }
  }

  String revertPlayerTurn({required String actualPlayer}) =>
      actualPlayer == 'X' ? 'O' : 'X';

  void resetBoard() => emit(
        state.copyWith(
          board: List.filled(9, '', growable: false),
          status: GameStatus.initial,
        ),
      );

  bool _hasWinner({required List<String> board}) {
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

  void increaseWinScore({
    required String playerTurn,
  }) {
    if (playerTurn == 'X') {
      return emit(
        state.copyWith(
          xPlayerScore: state.xPlayerScore + 1,
          status: GameStatus.hasWinner,
          gameWinner: playerTurn,
          playerTurn: revertPlayerTurn(actualPlayer: playerTurn),
        ),
      );
    } else {
      return emit(
        state.copyWith(
          oPlayerScore: state.oPlayerScore + 1,
          status: GameStatus.hasWinner,
          gameWinner: playerTurn,
          playerTurn: revertPlayerTurn(actualPlayer: playerTurn),
        ),
      );
    }
  }

  void increaseDrawScore() => emit(
        state.copyWith(
          drawGameScore: state.drawGameScore + 1,
          status: GameStatus.hasDraw,
        ),
      );

  void resetScore() => emit(
        state.copyWith(
            xPlayerScore: 0,
            oPlayerScore: 0,
            drawGameScore: 0,
            status: GameStatus.initial),
      );

  bool _hasDraw({required List<String> board}) => !board.contains('');
}
