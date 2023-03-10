import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:rxdart/rxdart.dart';

class AddBookSearch extends ConsumerStatefulWidget {
  const AddBookSearch({required this.onFocus, super.key});

  final VoidCallback onFocus;

  @override
  ConsumerState<AddBookSearch> createState() => _AddBookInputSearch();
}

class _AddBookInputSearch extends ConsumerState<AddBookSearch> {
  final _focusNode = FocusNode();
  final _searchSubject = PublishSubject<String>();
  bool _focusedYet = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusChange);
    final addBookStateNotifier = ref.read(addBookPageStateNotifierProvider.notifier);
    _searchSubject.debounceTime(const Duration(seconds: 1)).listen((String searchTerm) {
      addBookStateNotifier.search(searchTerm);
    });

  }

  void _addToSubject(String searchTerm) {
    _searchSubject.add(searchTerm);
  }

  void _focusChange() {
    if (_focusNode.hasFocus && !_focusedYet) {
      widget.onFocus();
      _focusedYet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration:
          InputDecoration(hintText: AppLocalizations.of(context)!.searchAbook, suffixIcon: const Icon(Icons.search)),
      onChanged: _addToSubject,
      textInputAction: TextInputAction.done,
      focusNode: _focusNode,
    );
  }
}
