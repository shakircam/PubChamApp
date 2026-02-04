import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  final String viewParam;
  const OtherPage({this.viewParam = ""});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'OtherView',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
