import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/database_service.dart';
import '../widgets/expense_card.dart';
import '../widgets/add_expense_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseService _dbService;
  List<Expense> _expenses = [];
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _dbService = DatabaseService();
    _loadExpenses();
  }

  void _loadExpenses() async {
    final expenses = await _dbService.getExpenses();
    final total = await _dbService.getTotalExpenses();
    setState(() {
      _expenses = expenses;
      _total = total;
    });
  }

  void _addExpense(Expense expense) async {
    await _dbService.addExpense(expense);
    _loadExpenses();
  }

  void _deleteExpense(int id) async {
    await _dbService.deleteExpense(id);
    _loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: const Color(0xFFF5E6D3),
        elevation: 0,
        foregroundColor: const Color(0xFF5A4A42),
      ),
      backgroundColor: const Color(0xFFFAF6F1),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF5E6D3), Color(0xFFEDD5C1)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Total Expenses',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(
                  '₹${_total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD97757),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _expenses.isEmpty
                ? Center(
                    child: Text(
                      'No expenses yet',
                      style: TextStyle(color: Colors.grey[400], fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      return ExpenseCard(
                        expense: _expenses[index],
                        onDelete: _deleteExpense,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD97757),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddExpenseDialog(onAdd: _addExpense),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
