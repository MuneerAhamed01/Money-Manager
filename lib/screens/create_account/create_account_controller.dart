import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/dashboard/dashbaord_screen.dart';
import 'package:money_manager/services/auth/firebase_auth.dart';
import 'package:money_manager/utils/snackbar.dart';

class CreateAccountController extends GetxController {
  final AuthService _auth;

  CreateAccountController({required AuthService auth}) : _auth = auth;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  Future<void> onContinue() async {
    if (formState.currentState!.validate()) {
      isLoading.value = true;

      final result = await _auth.createUserWithEmail(
        emailController.text,
        passwordController.text,
      );

      await result.fold((e) {
        showSnackBar('Something went wrong. Please try again');
      }, _onCreateAccount);

      isLoading.value = false;
    }
  }

  Future<void> _onCreateAccount(UserCredential cred) async {
    final result = await _auth.storeUserDetails(
        cred.user!.uid, nameController.text, emailController.text);
    result.fold((e) {
      showSnackBar('Something went wrong. Please try again');
      isLoading.value = false;
    }, (e) async {
      // Navigate
      isLoading.value = false;

      await _auth.getCurrentUserDetails();
      Get.offAllNamed(DashbaordScreen.routeName);
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
