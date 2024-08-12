import 'package:get/get.dart';
import 'package:money_manager/screens/transaction_history/transaction_history_controller.dart';

class TransactionHistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionHistoryController());
  }
}
