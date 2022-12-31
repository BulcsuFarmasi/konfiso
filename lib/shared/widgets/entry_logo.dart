import 'package:flutter/material.dart';

class EntryLogo extends StatelessWidget {
  const EntryLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/entry_logo.png',
      width: 128,
    );
  }
}
