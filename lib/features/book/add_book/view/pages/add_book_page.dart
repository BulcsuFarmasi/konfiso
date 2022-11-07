import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

  static const routeName = '/add-book';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('Add a Book')),
        centerTitle: true,
      ),
    );
  }
}
