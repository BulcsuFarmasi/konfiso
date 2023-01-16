import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:rxdart/rxdart.dart';

class AddBookSearch extends ConsumerStatefulWidget {
  const AddBookSearch({required this.startedTyping, super.key});

  final VoidCallback startedTyping;

  @override
  ConsumerState<AddBookSearch> createState() => _AddBookInputSearch();
}

class _AddBookInputSearch extends ConsumerState<AddBookSearch> {
  final searchSubject = PublishSubject<String>();
  bool isTypingYet = false;

  @override
  void initState() {
    super.initState();
    final addBookStateNotifier = ref.read(addBookPageStateNotifierProvider.notifier);
    searchSubject.debounceTime(const Duration(seconds: 1)).listen((String searchTerm) {
      addBookStateNotifier.search(searchTerm);
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
      decoration:
          InputDecoration(hintText: AppLocalizations.of(context)!.searchAbook, suffixIcon: const Icon(Icons.search)),
      onChanged: _addToSubject,
      textInputAction: TextInputAction.done,
    );
  }
}
