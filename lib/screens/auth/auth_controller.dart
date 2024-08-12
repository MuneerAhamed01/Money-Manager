import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/dashboard/dashbaord_screen.dart';
import 'package:money_manager/services/auth/firebase_auth.dart';
import 'package:money_manager/utils/snackbar.dart';

class AuthController extends GetxController {
  final AuthService _auth;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  AuthController({required AuthService auth}) : _auth = auth;

  RxBool isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;
      final result = await _auth.signInWithEmail(
        emailController.text,
        passwordController.text,
      );

      result.fold((e) {
        isLoading.value = false;

        if (e.contains(
            'The supplied auth credential is incorrect, malformed or has expired.')) {
          showSnackBar('Please check your crediantals is signed or not');
        }
      }, _onSuccessLogin);
    } else {
      showSnackBar('Please enter your email and password');
    }
  }

  Future<void> _onSuccessLogin(UserCredential user) async {
    isLoading.value = false;
    await _auth.getCurrentUserDetails();

    Get.offAndToNamed(DashbaordScreen.routeName);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
