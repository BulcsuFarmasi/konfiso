import 'package:flutter/material.dart';

class BookDetailInProgress extends StatelessWidget {
  const BookDetailInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
