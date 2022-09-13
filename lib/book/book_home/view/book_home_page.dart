import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookHomePage extends StatelessWidget {
  const BookHomePage({super.key});

  static const routeName = '/books-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          Intl.message('Books'),
          style: const TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
