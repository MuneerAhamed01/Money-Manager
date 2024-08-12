import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/models/transaction/transaction.dart';
import 'package:money_manager/screens/transaction_history/widgets/filter_bottom_sheet.dart';
import 'package:money_manager/services/database/transactions.dart';
import 'package:money_manager/utils/categories.dart';
import 'package:money_manager/utils/transaction_enum/transaction_type.dart';

class TransactionHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  late final List<String> tabs;

  static String reBuildTabBarView = 'rebuild-tabBar';

  static String reBuildscreen = 'rebuild-screen';

  DateTime? startDate;

  DateTime? endDate;

  final TransactionsDataRepostiory _transactionRepo =
      TransactionsDataRepostiory.instance;

  @override
  void onInit() {
    tabs = ["All", ...categories];
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      update([reBuildscreen]);
    });
  }

  List<Transaction> getTransactions(String category) {
    final transactions = _transactionRepo.getTransactionByFiltering(
      category: category == 'All' ? null : category,
      startDate: startDate,
      endDate: endDate,
    );

    return transactions;
  }

  Future<void> deleteTransaction(int id) async {
    await _transactionRepo.deleteTransaction(id);
    update([reBuildTabBarView, reBuildscreen]);
  }

  Future<void> onFilter() async {
    final value = await Get.bottomSheet<DateTimeRange?>(
      isScrollControlled: false,
      isDismissible: false,
      enableDrag: false,
      FilterBottomSheet(
        initalRange: startDate != null && endDate != null
            ? DateTimeRange(end: endDate!, start: startDate!)
            : null,
      ),
    );

    if (value == null) {
      startDate = null;
      endDate = null;

      update([reBuildTabBarView, reBuildscreen]);
    } else {
      startDate = value.start;
      endDate = value.end;
      update([reBuildTabBarView, reBuildscreen]);
    }
  }

  double get getBalance {
    return _transactionRepo.getBalanceByFilteringFull(
      startDate: startDate,
      endDate: endDate,
      category: tabController.index == 0 ? null : tabs[tabController.index],
    );
  }

  double get getExpense {
    return _transactionRepo.getBalanceByFiltering(
      startDate: startDate,
      endDate: endDate,
      category: tabController.index == 0 ? null : tabs[tabController.index],
      type: TransactionType.expense,
    );
  }

  double get getIncome {
    return _transactionRepo.getBalanceByFiltering(
      startDate: startDate,
      endDate: endDate,
      category: tabController.index == 0 ? null : tabs[tabController.index],
      type: TransactionType.income,
    );
  }
}
