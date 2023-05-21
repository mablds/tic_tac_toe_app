import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../components/board.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreColors.primaryColor,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: CoreColors.primaryColor,
      ),
      body: const Board(),
    );
  }
}
