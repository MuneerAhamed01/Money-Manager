// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager/models/transaction/transaction.dart';
import 'package:money_manager/utils/transaction_enum/transaction_type.dart';

class TransactionsDataRepostiory extends GetxService {
  late final Box<Transaction> box;
  TransactionsDataRepostiory();

  @override
  Future<TransactionsDataRepostiory> onInit() async {
    if (!Hive.isAdapterRegistered(TransactionAdapter().typeId)) {
      Hive.registerAdapter<Transaction>(TransactionAdapter());
    }

    if (!Hive.isAdapterRegistered(TransactionTypeAdapter().typeId)) {
      Hive.registerAdapter<TransactionType>(TransactionTypeAdapter());
    }
    box = await Hive.openBox<Transaction>('transactions');
    super.onInit();

    return TransactionsDataRepostiory();
  }

  static TransactionsDataRepostiory get instance =>
      Get.find<TransactionsDataRepostiory>();

  Future<void> addTransaction(Transaction transaction) async {
    final result = await box.add(transaction);
    await box.put(result, transaction.copyWith(id: result));
    return;
  }

  List<Transaction> getTransactions() {
    return box.values.toList()
      ..sort((a, b) => b.addedDate.compareTo(a.addedDate));
  }

  Future<void> editTransaction(
    int transactionId,
    Transaction updatedTrans,
  ) async {
    await box.put(transactionId, updatedTrans);
  }

  Future<void> deleteTransaction(int transactionId) async {
    await box.delete(transactionId);
  }

  List<Transaction> getTransactionByCategory(String category) {
    return getTransactions().where((e) => e.category == category).toList();
  }

  List<Transaction> getTransactionsByDateRange(
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (startDate != null && endDate != null) {
      return getTransactions().where((item) {
        return (item.addedDate.isAfter(startDate.subtract(1.days)) &&
                item.addedDate.isBefore(endDate.add(1.days))) ||
            item.addedDate.isAtSameMomentAs(startDate) ||
            item.addedDate.isAtSameMomentAs(endDate);
      }).toList();
    }

    if (startDate != null) {
      return getTransactions().where((item) {
        return item.addedDate.isAfter(startDate.subtract(1.days)) ||
            item.addedDate.isAtSameMomentAs(startDate);
      }).toList();
    }

    if (endDate != null) {
      return getTransactions().where((item) {
        return item.addedDate.isBefore(endDate.add(1.days)) ||
            item.addedDate.isAtSameMomentAs(endDate);
      }).toList();
    }

    return getTransactions();
  }

  List<Transaction> getTransactionByFiltering({
    DateTime? startDate,
    DateTime? endDate,
    String? category,
    TransactionType? type,
  }) {
    List<Transaction> transactions = getTransactions();
    transactions = getTransactionsByDateRange(startDate, endDate);

    if (category != null) {
      transactions = transactions.where((e) => e.category == category).toList();
    }

    if (type != null) {
      transactions = transactions.where((e) => e.type == type).toList();
    }

    return transactions;
  }

  List<Transaction> getTranactionByType(TransactionType type) {
    return getTransactions().where((e) => e.type == type).toList();
  }

  double getTotalBalance() {
    final listOfExpense = getTranactionByType(TransactionType.expense);
    final listOfIncome = getTranactionByType(TransactionType.income);

    final double expenseAmount =
        listOfExpense.fold(0, (value, trans) => value + trans.amount);
    final double incomeAmount =
        listOfIncome.fold(0, (value, trans) => value + trans.amount);

    return incomeAmount - expenseAmount;
  }

  double getExpenseBalance() {
    final listOfExpense = getTranactionByType(TransactionType.expense);

    final double expenseAmount =
        listOfExpense.fold(0, (value, trans) => value + trans.amount);

    return expenseAmount;
  }

  double getIncomeBalance() {
    final listOfIncome = getTranactionByType(TransactionType.income);

    final double incomeAmount =
        listOfIncome.fold(0, (value, trans) => value + trans.amount);

    return incomeAmount;
  }

  double getBalanceByFiltering({
    DateTime? startDate,
    DateTime? endDate,
    String? category,
    TransactionType? type,
  }) {
    final data = getTransactionByFiltering(
      startDate: startDate,
      endDate: endDate,
      category: category,
      type: type,
    );

    final double amount = data.fold(0, (v, d) => d.amount + v);

    return amount;
  }

  double getBalanceByFilteringFull({
    DateTime? startDate,
    DateTime? endDate,
    String? category,
    TransactionType? type,
  }) {
    final data = getTransactionByFiltering(
      startDate: startDate,
      endDate: endDate,
      category: category,
      type: type,
    );

    final double expenseAmount = data
        .where((e) => e.type == TransactionType.expense)
        .fold(0, (v, d) => d.amount + v);

    final double income = data
        .where((e) => e.type == TransactionType.income)
        .fold(0, (v, d) => d.amount + v);

    return income - expenseAmount;
  }

  Future<void> bulkUpload(List<Transaction> transactions) async {
    for (var i in transactions) {
      await addTransaction(i);
    }
  }
}
