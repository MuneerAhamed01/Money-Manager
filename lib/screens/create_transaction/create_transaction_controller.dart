import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/models/transaction/transaction.dart';
import 'package:money_manager/screens/create_transaction/models/category_and_date_model.dart';
import 'package:money_manager/screens/create_transaction/widgets/category_widget.dart';
import 'package:money_manager/services/database/transactions.dart';
import 'package:money_manager/utils/snackbar.dart';
import 'package:money_manager/utils/transaction_enum/transaction_type.dart';

class CreateTransactionController extends GetxController {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController notesController = TextEditingController();

  static const String rebuildButton = 'rebuild_button';

  static const String transactionKey = 'transaction-key';

  static const String typeKey = 'typeKey';

  final TextEditingController amountController =
      TextEditingController(text: r'₹');

  FocusNode titleNode = FocusNode();
  FocusNode amountNode = FocusNode();
  FocusNode noteNode = FocusNode();

  Transaction? initalTransaction;

  late TransactionType type;

  @override
  void onInit() {
    type = Get.arguments[typeKey] as TransactionType;

    initalTransaction = Get.arguments[transactionKey] as Transaction?;

    if (initalTransaction != null) {
      titleController.text = initalTransaction?.title ?? '';
      amountController.text = "₹ ${initalTransaction?.amount}";
      notesController.text = initalTransaction?.note ?? '';
    }

    super.onInit();
  }

  void addAmount(String value) {
    if (value == '10') {
      amountController.text += '.';
    } else if (value == '11') {
      amountController.text += '0';
    } else if (value == "12") {
      String newValue = amountController.text;
      String modified = newValue.substring(0, newValue.length - 1);
      if (modified.isEmpty) modified = r'₹';
      amountController.text = modified;
    } else {
      amountController.text += value;
    }

    update([rebuildButton]);
  }

  Future<void> onTapAdd() async {
    if (titleController.text.isEmpty) {
      showSnackBar('Add title for your transaction');
      return;
    }

    if (amountController.text == r'₹') {
      showSnackBar('Amount should be atlease one rupee');
      return;
    }

    final value = await Get.bottomSheet<CategoryAndDateModel?>(
      isScrollControlled: false,
      isDismissible: false,
      enableDrag: false,
      CategoryWidgetBottomSheet(
        iniitalTime: initalTransaction?.addedDate,
        intialCategory: initalTransaction?.category,
      ),
    );

    String numericString = amountController.text.replaceAll("₹", "");

    final myData = Transaction(
      id: 0, // Not required for adding so just sample
      title: titleController.text,
      createdDate: DateTime.now(),
      addedDate: value?.date ?? DateTime.now(),
      amount: double.tryParse(numericString) ?? 0,
      category: value!.category!,
      note: notesController.text,
      type: type,
    );

    if (initalTransaction != null) {
      await TransactionsDataRepostiory.instance
          .editTransaction(initalTransaction!.id, myData);
    } else {
      await TransactionsDataRepostiory.instance.addTransaction(myData);
    }

    Get.back(result: true);
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    notesController.dispose();
    noteNode.dispose();
    amountNode.dispose();
    titleNode.dispose();

    super.onClose();
  }
}
