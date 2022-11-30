import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/add_book/view/pages/add_book_page.dart';
import 'package:konfiso/features/book/book_home/view/widgets/book_home_menu_item.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/shared/widgets/app_drawer/view/app_drawer.dart';

class BookHomePage extends StatelessWidget {
  const BookHomePage({super.key});

  static const routeName = '/books-home';

  void _navigateToAddBookPage(BuildContext context) {
    Navigator.of(context).pushNamed(AddBookPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.books,
        ),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: BookReadingStatus.values
                .map((BookReadingStatus readingStatus) =>
                    BookHomeMenuItem(key: ValueKey<BookReadingStatus>(readingStatus), readingStatus: readingStatus))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddBookPage(context);
        },
        elevation: 0,
        child: const Icon(Icons.add),
      ),
    );
  }
}
