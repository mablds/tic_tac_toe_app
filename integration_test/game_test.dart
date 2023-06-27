import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_app/main.dart';

void main() {
  group('Tic tac toe integration tests', () {
    testWidgets('Should render the filled tile', (WidgetTester tester) async {
      await tester.pumpWidget(const TicTacToe());

      await tester.tap(find.text('Reset'));
      await tester.tap(find.byKey(const Key('1')));

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('X'), findsOneWidget);
    });

    testWidgets(
        'Should not render any tile with O if it was pressed on a tile already filled',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TicTacToe());

      await tester.tap(find.byKey(const Key('1')));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('1')));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('X'), findsOneWidget);
      expect(find.text('O'), findsNothing);
    });

    testWidgets('Should render the win dialog', (WidgetTester tester) async {
      await tester.pumpWidget(const TicTacToe());

      await tester.tap(find.byKey(const Key('1')));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('2')));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('4')));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('5')));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('7')));
      await tester.pump(const Duration(seconds: 1));

      //- X O
      //- X O
      //- X -

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.textContaining('Jogar novamente'), findsOneWidget);
    });

    testWidgets('Should render the draw game dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TicTacToe());

      await tester.tap(find.byKey(const Key('1'))); //X
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('0'))); //O
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('3'))); //X
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('2'))); //O
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('6'))); //X
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('4'))); //O
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('8'))); //X
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('7'))); //O
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('5'))); //X
      await tester.pump(const Duration(seconds: 1));

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // O X O
      // X O X
      // X O X

      expect(find.textContaining('Jogar novamente'), findsOneWidget);
    });
  });
}
