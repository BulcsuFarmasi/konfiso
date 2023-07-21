import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicySuccessful extends StatefulWidget {
  const PrivacyPolicySuccessful(this._privacyPolicyUrl, {super.key});

  final String _privacyPolicyUrl;

  @override
  State<PrivacyPolicySuccessful> createState() => _PrivacyPolicySuccessfulState();
}

class _PrivacyPolicySuccessfulState extends State<PrivacyPolicySuccessful> {
  late final WebViewController webViewController;
  
  @override
  void initState() {
    print(widget._privacyPolicyUrl);
    webViewController = WebViewController()..loadRequest(Uri.parse(widget._privacyPolicyUrl));
  }


  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: webViewController);
  }
}
