import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PrivacyPolicySuccessful extends StatelessWidget {
  const PrivacyPolicySuccessful(this._privacyPolicyUrl, {super.key});

  final String _privacyPolicyUrl;

  @override
  Widget build(BuildContext context) {
    return const PDF().cachedFromUrl(_privacyPolicyUrl);
  }
}
