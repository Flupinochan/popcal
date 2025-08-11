import 'package:flutter/material.dart';

class CustomErrorSimpleScreen extends StatelessWidget {
  const CustomErrorSimpleScreen({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
