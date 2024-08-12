import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_controller.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_screen.dart';
import 'package:money_manager/screens/transaction_history/transaction_history_controller.dart';
import 'package:money_manager/utils/adaptive_action.dart';

class TransactionListView extends GetView<TransactionHistoryController> {
  const TransactionListView({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionHistoryController>(
        id: TransactionHistoryController.reBuildTabBarView,
        builder: (context) {
          final listOfTransactions = controller.getTransactions(category);

          if (listOfTransactions.isEmpty) {
            return const Center(child: Text('No Transaction found'));
          }
          return ListView.builder(
            itemCount: listOfTransactions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                key: ValueKey(listOfTransactions[index].id),
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
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            adaptiveAction(
                              context: context,
                              onPressed: () {
                                controller.deleteTransaction(
                                  listOfTransactions[index].id,
                                );
                                Navigator.pop(context, 'Delete');
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      });
                },
                onTap: () {
                  Get.toNamed(CreateTransactionScreen.routeName, arguments: {
                    CreateTransactionController.transactionKey:
                        listOfTransactions[index],
                    CreateTransactionController.typeKey:
                        listOfTransactions[index].type
                  })?.then((_) {
                    controller.update([
                      TransactionHistoryController.reBuildTabBarView,
                      TransactionHistoryController.reBuildscreen
                    ]);
                  });
                },
                title: Text(listOfTransactions[index].title),
                subtitle: Text(
                  listOfTransactions[index].category,
                  style: Get.textTheme.labelSmall
                      ?.copyWith(color: Get.theme.colorScheme.outline),
                ),
                trailing: Text('₹ ${listOfTransactions[index].amount}'),
              );
            },
          );
        });
  }
}
