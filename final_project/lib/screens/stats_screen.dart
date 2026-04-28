import 'package:flutter/material.dart';
import '../services/database_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late DatabaseService _dbService;
  Map<String, double> _categoryStats = {};
  double _monthlyTotal = 0.0;

  @override
  void initState() {
    super.initState();
    _dbService = DatabaseService();
    _loadStats();
  }

  void _loadStats() async {
    final stats = await _dbService.getCategoryStats();
    final monthly = await _dbService.getMonthlyTotal(DateTime.now());
    setState(() {
      _categoryStats = stats;
      _monthlyTotal = monthly;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = _categoryStats.values.fold<double>(
      0,
      (sum, val) => sum + val,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: const Color(0xFFF5E6D3),
        elevation: 0,
        foregroundColor: const Color(0xFF5A4A42),
      ),
      backgroundColor: const Color(0xFFFAF6F1),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Monthly Total Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.black.withValues(alpha: 0.1),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF5E6D3), Color(0xFFEDD5C1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'This Month',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${_monthlyTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD97757),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Category Breakdown',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Category Stats
          _categoryStats.isEmpty
              ? Center(
                  child: Text(
                    'No expenses yet',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                )
              : Column(
                  children: _categoryStats.entries.map((entry) {
                    final percentage = total > 0
                        ? (entry.value / total) * 100
                        : 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                entry.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '₹${entry.value.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD97757),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percentage / 100,
                              minHeight: 8,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFD97757).withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${percentage.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
