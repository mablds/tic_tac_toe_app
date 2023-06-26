import 'package:flutter_test/flutter_test.dart';

import 'package:tic_tac_toe_app/main.dart';

void main() {
  testWidgets('Should render te initial game screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToe());

    expect(find.text('Jogo da Velha'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);
  });
}
