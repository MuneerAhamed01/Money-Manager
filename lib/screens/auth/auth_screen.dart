import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/auth/auth_controller.dart';
import 'package:money_manager/screens/create_account/create_account_screen.dart';
import 'package:money_manager/widgets/button.dart';
import 'package:money_manager/widgets/textfield.dart';

class AuthScreen extends GetWidget<AuthController> {
  static String routeName = '/auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Welcome',
                style: Get.textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'Enjoy all the features that make it easy for you to manage your finances',
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 20),
              AppTextField(
                hintText: "Enter you email",
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              AppTextField(
                hintText: "Enter your password",
                controller: controller.passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 10),
              Obx(
                () => SizedBox(
                  height: 46,
                  width: Get.width,
                  child: AppButton(
                    label: 'Continue',
                    onTap: controller.login,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: Get.textTheme.labelLarge
                  ?.copyWith(color: Colors.black, letterSpacing: 0.8),
              children: [
                TextSpan(
                  text: 'Register',
                  style: Get.textTheme.labelLarge
                      ?.copyWith(color: Colors.blue, letterSpacing: 0.8),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(CreateAccountScreen.routeName);
                    },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom + 20,
          )
        ],
      ),
    );
  }
}
