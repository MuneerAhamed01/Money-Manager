import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_controller.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_screen.dart';
import 'package:money_manager/screens/dashboard/dashboard_controller.dart';
import 'package:money_manager/screens/dashboard/widgets/add_money_widget.dart';
import 'package:money_manager/screens/dashboard/widgets/column_tile.dart';
import 'package:money_manager/screens/settings/settings_screen.dart';
import 'package:money_manager/screens/transaction_history/transaction_history_screen.dart';
import 'package:money_manager/services/auth/firebase_auth.dart';
import 'package:money_manager/utils/adaptive_action.dart';

class DashbaordScreen extends GetView<DashboardController> {
  static const String routeName = '/dashboard';
  const DashbaordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: GetBuilder<DashboardController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  color: Colors.black.withOpacity(0.88),
                  padding: const EdgeInsets.all(16),
                  height: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Balance',
                        style: Get.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '₹ ${controller.getBalanceAmount}',
                        style: Get.textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      const SizedBox(height: 5),
                      _buildExpenseAndIncome(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: AddMoneyWidget(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Recent Transactions :',
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(TransactionHistoryScreen.routeName)
                              ?.then((e) {
                            Get.find<DashboardController>().update();
                          });
                        },
                        child: Text(
                          'View all',
                          style: Get.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.getList.isEmpty) ...[
                  const SizedBox(height: 20),
                  const Center(child: Text('There is no transaction added'))
                ] else
                  ListView.builder(
                    itemCount: controller.getList.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return ListTile(
                        key: ValueKey(controller.getList[index].id),
                        onLongPress: () {
                          showAdaptiveDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog.adaptive(
                                  title: const Text('Delete Transaction'),
                                  content: const Text('Are you sure?'),
                                  actions: <Widget>[
                                    adaptiveAction(
                                      context: context,
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    adaptiveAction(
                                      context: context,
                                      onPressed: () {
                                        controller.deleteTransaction(
                                          controller.getList[index].id,
                                        );
                                        Navigator.pop(context, 'Delete');
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              });
                        },
                        onTap: () async {
                          Get.toNamed(CreateTransactionScreen.routeName,
                              arguments: {
                                CreateTransactionController.transactionKey:
                                    controller.getList[index],
                                CreateTransactionController.typeKey:
                                    controller.getList[index].type
                              })?.then((_) {
                            Get.find<DashboardController>().update();
                          });
                        },
                        title: Text(controller.getList[index].title),
                        subtitle: Text(
                          controller.getList[index].category,
                          style: Get.textTheme.labelSmall
                              ?.copyWith(color: Get.theme.colorScheme.outline),
                        ),
                        trailing: Text('₹ ${controller.getList[index].amount}'),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildExpenseAndIncome() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ColumnTile(
            text: 'Expense',
            amount: '₹ ${controller.getExpense}',
          ),
          const Spacer(),
          Container(
            height: 60,
            width: 1,
            color: Colors.white,
          ),
          const Spacer(),
          ColumnTile(
            text: 'Income',
            amount: '₹ ${controller.getIncome}',
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Hi ${Get.user?.name}",
        style: Get.textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(SettingsScreen.routeName);
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Center(
              child: Text(
                Get.user?.name[0] ?? 'U',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      leadingWidth: 40,
      backgroundColor: Colors.black.withOpacity(0.88),
      elevation: 0,
    );
  }
}
