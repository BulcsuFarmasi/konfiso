import 'package:flutter/material.dart';

// helper widget to immediately call callback during it is initialization
class Callback extends StatefulWidget {
  const Callback({super.key, required this.child, required this.callback});

  final Widget child;
  final VoidCallback callback;

  @override
  State<Callback> createState() => _CallbackState();
}

class _CallbackState extends State<Callback> {
  @override
  void initState() {
    super.initState();
    widget.callback();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
