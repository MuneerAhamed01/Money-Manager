import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/utils/transaction_enum/transaction_type.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime createdDate;

  @HiveField(3)
  final DateTime addedDate;

  @HiveField(4)
  final double amount;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final String note;

  @HiveField(7)
  final TransactionType type;

  Transaction({
    required this.id,
    required this.title,
    required this.createdDate,
    required this.addedDate,
    required this.amount,
    required this.category,
    required this.note,
    required this.type,
  });

  Transaction copyWith({
    int? id,
    String? title,
    DateTime? createdDate,
    DateTime? addedDate,
    double? amount,
    String? category,
    String? note,
    TransactionType? type,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      createdDate: createdDate ?? this.createdDate,
      addedDate: addedDate ?? this.addedDate,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      note: note ?? this.note,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'addedDate': addedDate.millisecondsSinceEpoch,
      'amount': amount,
      'category': category,
      'note': note,
      'type': type.name,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      title: map['title'] as String,
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
      addedDate: DateTime.fromMillisecondsSinceEpoch(map['addedDate'] as int),
      amount: map['amount'] as double,
      category: map['category'] as String,
      note: map['note'] as String,
      type: TransactionType.values.firstWhere((e) => e == map['type']),
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, createdDate: $createdDate, addedDate: $addedDate, amount: $amount, category: $category, note: $note, type: $type)';
  }
}
