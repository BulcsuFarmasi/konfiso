import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailStatusForm extends ConsumerStatefulWidget {
  const BookDetailStatusForm({super.key});

  @override
  ConsumerState<BookDetailStatusForm> createState() =>
      _BookDetailStatusFormState();
}

class _BookDetailStatusFormState extends ConsumerState<BookDetailStatusForm> {
  @override
  Widget build(BuildContext context) {
    return Form(child: Column(children: [],));
  }
}
