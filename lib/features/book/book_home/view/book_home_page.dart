import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/shared/widgets/app_drawer.dart';

class BookHomePage extends StatelessWidget {
  const BookHomePage({super.key});

  static const routeName = '/books-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Center(
        child: Text(
          Intl.message('Books'),
          style: const TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
