import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColumnTile extends StatelessWidget {
  const ColumnTile({
    super.key,
    required this.text,
    required this.amount,
  });

  final String text;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$text :",
          style: Get.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            amount,
            style: Get.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
