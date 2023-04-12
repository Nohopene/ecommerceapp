import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoneyWidget extends StatelessWidget {
  final double size;
  final int value;
  const MoneyWidget({super.key, required this.size, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      NumberFormat.simpleCurrency(locale: 'vi-VN').format(value),
      style: TextStyle(
          color: Colors.red, fontSize: size, fontWeight: FontWeight.w500),
    );
  }
}
