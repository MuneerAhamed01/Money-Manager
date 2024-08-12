import 'package:get/get.dart';
import 'package:money_manager/screens/dashboard/dashboard_controller.dart';
import 'package:money_manager/screens/settings/utils/dummy_transaction.dart';
import 'package:money_manager/services/database/transactions.dart';
import 'package:money_manager/utils/snackbar.dart';

class SettingsController extends GetxController {
  addBulktransactions() async {
    await TransactionsDataRepostiory.instance.bulkUpload(transactions);
    showSnackBar('Transaction uploaded successfully', true);
    Get.find<DashboardController>().update();
  }
}
