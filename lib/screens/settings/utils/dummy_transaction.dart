import 'package:money_manager/models/transaction/transaction.dart';
import 'package:money_manager/utils/transaction_enum/transaction_type.dart';

final List<Transaction> transactions = [
  Transaction(
    id: 1,
    title: 'Grocery Shopping',
    createdDate: DateTime(2024, 8, 1),
    addedDate: DateTime(2024, 8, 1),
    amount: 150.50,
    category: 'Food',
    note: 'Bought weekly groceries from the supermarket',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 2,
    title: 'Monthly Rent',
    createdDate: DateTime(2024, 8, 1),
    addedDate: DateTime(2024, 8, 1),
    amount: 1200.00,
    category: 'Housing',
    note: 'Paid rent for the apartment',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 3,
    title: 'Salary',
    createdDate: DateTime(2024, 8, 1),
    addedDate: DateTime(2024, 8, 1),
    amount: 3000.00,
    category: 'Savings & Investments',
    note: 'Received monthly salary',
    type: TransactionType.income,
  ),
  Transaction(
    id: 4,
    title: 'Electricity Bill',
    createdDate: DateTime(2024, 8, 5),
    addedDate: DateTime(2024, 8, 5),
    amount: 85.30,
    category: 'Bills & Utilities',
    note: 'Paid electricity bill for the month',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 5,
    title: 'Dinner at Restaurant',
    createdDate: DateTime(2024, 8, 7),
    addedDate: DateTime(2024, 8, 7),
    amount: 60.75,
    category: 'Entertainment',
    note: 'Dinner with friends at a local restaurant',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 6,
    title: 'Freelance Project',
    createdDate: DateTime(2024, 8, 10),
    addedDate: DateTime(2024, 8, 10),
    amount: 500.00,
    category: 'Savings & Investments',
    note: 'Payment received for freelance web development project',
    type: TransactionType.income,
  ),
  Transaction(
    id: 7,
    title: 'Gym Membership',
    createdDate: DateTime(2024, 8, 12),
    addedDate: DateTime(2024, 8, 12),
    amount: 45.00,
    category: 'Health & Fitness',
    note: 'Monthly gym membership fee',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 8,
    title: 'Monthly Savings',
    createdDate: DateTime(2024, 8, 15),
    addedDate: DateTime(2024, 8, 15),
    amount: 400.00,
    category: 'Savings & Investments',
    note: 'Transferred to savings account',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 9,
    title: 'Uber Ride',
    createdDate: DateTime(2024, 8, 17),
    addedDate: DateTime(2024, 8, 17),
    amount: 15.20,
    category: 'Transportation',
    note: 'Uber ride to the office',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 10,
    title: 'Concert Tickets',
    createdDate: DateTime(2024, 8, 20),
    addedDate: DateTime(2024, 8, 20),
    amount: 120.00,
    category: 'Entertainment',
    note: 'Bought tickets for a live concert',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 11,
    title: 'Dividend Income',
    createdDate: DateTime(2024, 8, 22),
    addedDate: DateTime(2024, 8, 22),
    amount: 200.00,
    category: 'Savings & Investments',
    note: 'Received dividends from stock investments',
    type: TransactionType.income,
  ),
  Transaction(
    id: 12,
    title: 'New Shoes',
    createdDate: DateTime(2024, 8, 25),
    addedDate: DateTime(2024, 8, 25),
    amount: 75.50,
    category: 'Shopping',
    note: 'Bought a new pair of running shoes',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 13,
    title: 'Weekend Getaway',
    createdDate: DateTime(2024, 8, 28),
    addedDate: DateTime(2024, 8, 28),
    amount: 300.00,
    category: 'Travel',
    note: 'Weekend trip to the mountains',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 14,
    title: 'Bonus',
    createdDate: DateTime(2024, 8, 30),
    addedDate: DateTime(2024, 8, 30),
    amount: 1000.00,
    category: 'Savings & Investments',
    note: 'Received performance bonus',
    type: TransactionType.income,
  ),
  Transaction(
    id: 15,
    title: 'Phone Bill',
    createdDate: DateTime(2024, 8, 31),
    addedDate: DateTime(2024, 8, 31),
    amount: 50.00,
    category: 'Bills & Utilities',
    note: 'Paid monthly phone bill',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 16,
    title: 'Coffee',
    createdDate: DateTime(2024, 8, 2),
    addedDate: DateTime(2024, 8, 2),
    amount: 5.00,
    category: 'Food',
    note: 'Morning coffee at the café',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 17,
    title: 'Freelance Article',
    createdDate: DateTime(2024, 8, 3),
    addedDate: DateTime(2024, 8, 3),
    amount: 150.00,
    category: 'Savings & Investments',
    note: 'Payment received for writing an article',
    type: TransactionType.income,
  ),
  Transaction(
    id: 18,
    title: 'Fuel',
    createdDate: DateTime(2024, 8, 4),
    addedDate: DateTime(2024, 8, 4),
    amount: 40.00,
    category: 'Transportation',
    note: 'Filled up gas tank',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 19,
    title: 'Birthday Gift',
    createdDate: DateTime(2024, 8, 6),
    addedDate: DateTime(2024, 8, 6),
    amount: 30.00,
    category: 'Miscellaneous',
    note: 'Bought a gift for a friend’s birthday',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 20,
    title: 'Car Repair',
    createdDate: DateTime(2024, 8, 8),
    addedDate: DateTime(2024, 8, 8),
    amount: 250.00,
    category: 'Transportation',
    note: 'Repaired car brakes',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 21,
    title: 'Sold Old Laptop',
    createdDate: DateTime(2024, 8, 9),
    addedDate: DateTime(2024, 8, 9),
    amount: 200.00,
    category: 'Savings & Investments',
    note: 'Sold old laptop online',
    type: TransactionType.income,
  ),
  Transaction(
    id: 22,
    title: 'Online Course',
    createdDate: DateTime(2024, 8, 11),
    addedDate: DateTime(2024, 8, 11),
    amount: 100.00,
    category: 'Education',
    note: 'Paid for an online course',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 23,
    title: 'Health Insurance',
    createdDate: DateTime(2024, 8, 13),
    addedDate: DateTime(2024, 8, 13),
    amount: 150.00,
    category: 'Health & Fitness',
    note: 'Paid for health insurance premium',
    type: TransactionType.expense,
  ),
  Transaction(
    id: 24,
    title: 'Sold Old Furniture',
    createdDate: DateTime(2024, 8, 18),
    addedDate: DateTime(2024, 8, 18),
    amount: 75.00,
    category: 'Savings & Investments',
    note: 'Sold old furniture pieces',
    type: TransactionType.income,
  ),
];
