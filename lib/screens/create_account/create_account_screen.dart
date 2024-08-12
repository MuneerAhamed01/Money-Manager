import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/create_account/create_account_controller.dart';
import 'package:money_manager/services/utilities/validator.dart';
import 'package:money_manager/widgets/button.dart';
import 'package:money_manager/widgets/textfield.dart';

class CreateAccountScreen extends GetWidget<CreateAccountController> {
  static String routeName = '/createAccount';
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create your Account',
                  style: Get.textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Create your account to make the account safe and good',
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: controller.emailController,
                  hintText: "Enter you email",
                  validator: (email) =>
                      validateInput(ValidationType.email, email ?? ''),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: controller.nameController,
                  hintText: "Enter you name",
                  validator: (email) =>
                      validateInput(ValidationType.name, email ?? ''),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: controller.passwordController,
                  hintText: "Enter your password",
                  validator: (email) =>
                      validateInput(ValidationType.password, email ?? ''),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 46,
                width: Get.width,
                child: AppButton(
                  label: 'Continue',
                  onTap: controller.onContinue,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
