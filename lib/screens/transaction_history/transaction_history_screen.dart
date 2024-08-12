import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/transaction_history/transaction_history_controller.dart';
import 'package:money_manager/screens/transaction_history/widgets/transaction_listview.dart';

class TransactionHistoryScreen extends GetView<TransactionHistoryController> {
  static const String routeName = '/transactionHistory';
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.88),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
              onPressed: controller.onFilter,
              icon: const Icon(
                Icons.filter_alt_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: GetBuilder<TransactionHistoryController>(
        id: TransactionHistoryController.reBuildscreen,
        builder: (context) {
          return Column(
            children: [
              Container(
                width: Get.width,
                color: Colors.black.withOpacity(0.88),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          _buildCurrentBalance(),
                          const Spacer(),
                          _buildExpenseAndIncome(),
                        ],
                      ),
                    ),
                    TabBar(
                      indicator: const UnderlineTabIndicator(),
                      tabAlignment: TabAlignment.start,
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.white,
                      isScrollable: true,
                      controller: controller.tabController,
                      tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: controller.tabs.map((e) {
                    return TransactionListView(category: e);
                  }).toList(),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Column _buildCurrentBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Balance :',
          style: Get.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '₹ ${controller.getBalance}',
          style: Get.textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Column _buildExpenseAndIncome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Expense :',
          style: Get.textTheme.labelMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '₹ ${controller.getExpense}',
          style: Get.textTheme.labelMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Income :',
          style: Get.textTheme.labelMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '₹ ${controller.getIncome}',
          style: Get.textTheme.labelMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
