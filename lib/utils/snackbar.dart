import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String message, [bool isSuccess = false]) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ),
  );
}
