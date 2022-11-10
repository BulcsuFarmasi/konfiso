import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:rxdart/rxdart.dart';

class AddBookSearch extends ConsumerStatefulWidget {
  const AddBookSearch(
      {required this.keyBoardDisappeared,
      required this.startedTyping,
      super.key});

  final VoidCallback startedTyping;
  final VoidCallback keyBoardDisappeared;

  @override
  ConsumerState<AddBookSearch> createState() => _AddBookInputSearch();
}

class _AddBookInputSearch extends ConsumerState<AddBookSearch> {
  final searchSubject = PublishSubject<String>();
  bool isTypingYet = false;

  @override
  void initState() {
    super.initState();
    final addBookStateNotifier =
        ref.read(addBookPageStateNotifierProvider.notifier);
    searchSubject
        .debounceTime(const Duration(milliseconds: 250))
        .listen((String searchTerm) {
      addBookStateNotifier.search(searchTerm);
    });
    searchSubject.debounceTime(const Duration(seconds: 2)).listen((_) {
      FocusManager.instance.primaryFocus?.unfocus();
      widget.keyBoardDisappeared();
    });
  }

  void _addToSubject(String searchTerm) {
    searchSubject.add(searchTerm);
    if (!isTypingYet) {
      widget.startedTyping();
      isTypingYet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: Intl.message('Search book by title'),
          suffixIcon: const Icon(Icons.search)),
      onChanged: _addToSubject,
      textInputAction: TextInputAction.done,
    );
  }
}
