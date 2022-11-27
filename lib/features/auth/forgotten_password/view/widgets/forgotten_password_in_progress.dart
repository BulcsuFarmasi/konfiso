import 'package:flutter/material.dart';

class ForgottenPasswordInProgress extends StatelessWidget {
  const ForgottenPasswordInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
