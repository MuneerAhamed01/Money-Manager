import 'package:get/get.dart';
import 'package:money_manager/screens/create_transaction/create_transaction_controller.dart';

class CreateTransactionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTransactionController());
  }
}
