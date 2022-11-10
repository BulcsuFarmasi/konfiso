import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_in_progress.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_search.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_success.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const AddBookSearch(),
            const SizedBox(
              height: 20,
            ),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final state = ref.watch(addBookPageStateNotifierProvider);
                return state.maybeMap(
                    inProgress: (_) => const AddBookInProgress(),
                    successful: (success) => AddBookSuccess(
                          books: success.books,
                        ),
                    error: (_) => Container(),
                    orElse: () => Container());
              },
            ),
          ],
        ),
      ),
    );
  }
}
