import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_controller.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_screen.dart';
import 'package:money_manager/screens/dashboard/dashboard_controller.dart';
import 'package:money_manager/utils/assets.dart';
import 'package:money_manager/utils/snackbar.dart';
import 'package:money_manager/utils/transaction_enum/transaction_type.dart';

class AddMoneyWidget extends StatelessWidget {
  const AddMoneyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const _AddingExpenseOrIncome(
            type: TransactionType.expense,
          ),
          Container(
            height: 60,
            width: 1,
            color: Colors.black,
          ),
          const _AddingExpenseOrIncome(
            type: TransactionType.income,
          ),
        ],
      ),
    );
  }
}

class _AddingExpenseOrIncome extends StatelessWidget {
  const _AddingExpenseOrIncome({required this.type});
  final TransactionType type;

  String get logo => type == TransactionType.expense
      ? MyAssets.expenseLogo
      : MyAssets.incomeLogo;

  String get label =>
      type == TransactionType.expense ? 'Add Expense' : "Add Income";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.horizontal(
          left: type == TransactionType.expense
              ? const Radius.circular(16)
              : const Radius.circular(0),
          right: type == TransactionType.income
              ? const Radius.circular(16)
              : const Radius.circular(0),
        ),
        onTap: () async {
          final response = await Get.toNamed(
            CreateTransactionScreen.routeName,
            arguments: {CreateTransactionController.typeKey: type},
          );

          if (response == true) {
            Get.find<DashboardController>().update();
            showSnackBar('Transaction added sucessful', true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset(logo),
              const SizedBox(height: 10),
              Text(
                label,
                style: Get.textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
