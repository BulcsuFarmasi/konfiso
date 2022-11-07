import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/book/%20model/book_reading_status.dart';
import 'package:konfiso/features/book/book_home/view/widgets/book_home_menu_item.dart';
import 'package:konfiso/shared/widgets/app_drawer/view/app_drawer.dart';

class BookHomePage extends StatelessWidget {
  const BookHomePage({super.key});

  static const routeName = '/books-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Intl.message('Books'),
        ),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: BookReadingStatus.values
              .map((BookReadingStatus readingStatus) =>
                  BookHomeMenuItem(key: ValueKey<BookReadingStatus>(readingStatus), readingStatus: readingStatus))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: const Icon(Icons.add),
      ),
    );
  }
}
