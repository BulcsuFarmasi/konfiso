import 'package:flutter/material.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class EntryInProgress extends StatelessWidget {
  const EntryInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: const [
          SizedBox(
            height: 168,
          ),
          EntryLogo(),
          SizedBox(
            height: 64,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
