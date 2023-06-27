import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_app/main.dart';

void main() {
  group(
    'Tic tac toe widget tests',
    () {
      testWidgets('Should render the initial game screen',
          (WidgetTester tester) async {
        await tester.pumpWidget(const TicTacToe());

        await tester.pumpAndSettle();

        expect(find.text('Jogo da Velha'), findsOneWidget);
        expect(find.text('Reset'), findsOneWidget);
      });

      testWidgets('Should render the filled tile', (WidgetTester tester) async {
        await tester.pumpWidget(const TicTacToe());

        await tester.tap(find.text('Reset'));
        await tester.tap(find.byKey(const Key('1')));

        await tester.pump(const Duration(seconds: 1));

        expect(find.text('X'), findsOneWidget);
      });
    },
  );
}
