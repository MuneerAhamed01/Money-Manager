import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_controller.dart';
import 'package:money_manager/utils/assets.dart';
import 'package:money_manager/utils/transaction_enum/transaction_type.dart';
import 'package:money_manager/widgets/button.dart';

class CreateTransactionScreen extends GetView<CreateTransactionController> {
  static const String routeName = '/create-transaction';

  const CreateTransactionScreen({super.key});

  List<String> get numbers =>
      List.generate(12, (index) => (index + 1).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black,
        title: Text(
          controller.initalTransaction != null
              ? controller.type == TransactionType.expense
                  ? "Update Expense"
                  : 'Update Income'
              : controller.type == TransactionType.expense
                  ? "Add Expense"
                  : 'Add Income',
          style: Get.textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            DecoratedBox(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                child: SvgPicture.asset(
                  controller.type == TransactionType.expense
                      ? MyAssets.expenseLogo
                      : MyAssets.incomeLogo,
                  // ignore: deprecated_member_use
                  color: Colors.white,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.titleController,
              style: Get.textTheme.labelMedium
                  ?.copyWith(fontSize: 16, color: Colors.white),
              maxLines: 1,
              cursorColor: Colors.white,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Add Title',
                border: _buildInputBorder(),
                errorBorder: _buildInputBorder(),
                focusedBorder: _buildInputBorder(),
                enabledBorder: _buildInputBorder(),
                disabledBorder: _buildInputBorder(),
              ),
            ),
            TextField(
              controller: controller.amountController,
              maxLines: 1,
              style: Get.textTheme.headlineLarge?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
              onChanged: (v) {
                if (v.isEmpty) {
                  controller.amountController.text = r'';
                }
              },
              cursorColor: Colors.white,
              decoration: InputDecoration(
                prefixStyle: Get.textTheme.headlineLarge,
                border: _buildInputBorder(),
                errorBorder: _buildInputBorder(),
                focusedBorder: _buildInputBorder(),
                enabledBorder: _buildInputBorder(),
                disabledBorder: _buildInputBorder(),
              ),
              readOnly: true,
            ),
            TextField(
              controller: controller.notesController,
              style: Get.textTheme.labelMedium
                  ?.copyWith(fontSize: 16, color: Colors.white),
              maxLines: 1,
              cursorColor: Colors.white,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Add a note (optional)',
                border: _buildInputBorder(),
                errorBorder: _buildInputBorder(),
                focusedBorder: _buildInputBorder(),
                enabledBorder: _buildInputBorder(),
                disabledBorder: _buildInputBorder(),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildButton(),
            _buildNumbers(),
            SizedBox(height: Get.mediaQuery.viewInsets.bottom + 20)
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return GetBuilder<CreateTransactionController>(
        id: CreateTransactionController.rebuildButton,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 48,
              child: AppButton(
                label: controller.initalTransaction != null
                    ? "Update ${controller.amountController.text}"
                    : 'Add ${controller.amountController.text}',
                borderColor: Colors.white,
                onTap: controller.onTapAdd,
              ),
            ),
          );
        });
  }

  Widget _buildNumbers() {
    return GridView.builder(
      itemCount: numbers.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemBuilder: (ctx, index) {
        return Material(
          color: Colors.white,
          // shadowColor: Colors.black,
          child: InkWell(
            onTap: () {
              controller.addAmount(numbers[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              child: Center(
                  child: Text(numbers[index] == "10"
                      ? '.'
                      : numbers[index] == '11'
                          ? "0"
                          : numbers[index] == '12'
                              ? 'x'
                              : numbers[index])),
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));
  }
}
