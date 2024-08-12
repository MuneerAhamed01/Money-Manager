import 'package:get/get.dart';
import 'package:money_manager/models/transaction/transaction.dart';
import 'package:money_manager/services/database/transactions.dart';
import 'package:money_manager/services/notifications/schedule_notification_local.dart';
import 'package:money_manager/widgets/schedule_bottom_sheet.dart';

class DashboardController extends GetxController {
  final TransactionsDataRepostiory _repostiory =
      TransactionsDataRepostiory.instance;

  double get getBalanceAmount {
    return _repostiory.getTotalBalance();
  }

  double get getExpense {
    return _repostiory.getExpenseBalance();
  }

  double get getIncome {
    return _repostiory.getIncomeBalance();
  }

  List<Transaction> get getList {
    return _repostiory.getTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await _repostiory.deleteTransaction(id);
    update();
  }

  void _checkScheduleNotificationDone() {
    if (!ScheduleNotificationLocal.instance.scheduled) {
      Get.bottomSheet(const ScheduleBottomSheet());
    }
  }

  @override
  void onReady() {
    super.onReady();
    _checkScheduleNotificationDone();
  }
}
