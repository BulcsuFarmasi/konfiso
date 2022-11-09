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

  final search = const AddBookSearch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('Add a Book')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final state = ref.watch(addBookPageStateNotifierProvider);
              return Column(
                children: [
                  const AddBookSearch(),
                  state.maybeMap(
                      inProgress: (_) => AddBookInProgress(
                            search: search,
                          ),
                      successful: (success) => Expanded(
                        child: AddBookSuccess(
                              books: success.books,
                              search: search,
                            ),
                      ),
                      error: (_) => Container(),
                      orElse: () => Container())
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
