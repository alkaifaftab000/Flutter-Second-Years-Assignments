import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final Function onDelete;

  const ExpenseCard({required this.expense, required this.onDelete, super.key});

  String _getCategoryIcon(String category) {
    final icons = {
      'Food': '🍔',
      'Transport': '🚗',
      'Shopping': '🛍️',
      'Entertainment': '🎬',
      'Other': '📌',
    };
    return icons[category] ?? '💰';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.withValues(alpha: 0.02)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Text(
            _getCategoryIcon(expense.category),
            style: const TextStyle(fontSize: 24),
          ),
          title: Text(
            expense.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            DateFormat('MMM dd, yyyy').format(expense.date),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₹${expense.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFFD97757),
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFFD97757),
                    size: 20,
                  ),
                  onPressed: () => onDelete(expense.id),
                  splashRadius: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
