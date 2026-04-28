import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/database_service.dart';
import '../widgets/expense_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late DatabaseService _dbService;
  List<Expense> _searchResults = [];
  final List<String> _searchHistory = [];
  final _searchController = TextEditingController();
  final List<String> _categories = [
    'All',
    'Food',
    'Transport',
    'Shopping',
    'Entertainment',
    'Other',
  ];
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _dbService = DatabaseService();
  }

  void _search(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    final results = await _dbService.searchExpenses(query);
    setState(() {
      _searchResults = results;
      if (!_searchHistory.contains(query)) {
        _searchHistory.insert(0, query);
        if (_searchHistory.length > 5) _searchHistory.removeLast();
      }
    });
  }

  void _filterByCategory(String category) {
    setState(() => _selectedCategory = category);
  }

  List<Expense> get _filteredResults {
    if (_selectedCategory == 'All') return _searchResults;
    return _searchResults
        .where((e) => e.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Expenses'),
        backgroundColor: const Color(0xFFF5E6D3),
        elevation: 0,
        foregroundColor: const Color(0xFF5A4A42),
      ),
      backgroundColor: const Color(0xFFFAF6F1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search expenses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Category Chips (Bento style)
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) => _filterByCategory(category),
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFFD97757),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFFD97757)
                            : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Search history or results
          Expanded(
            child: _searchController.text.isEmpty
                ? _searchHistory.isEmpty
                      ? Center(
                          child: Text(
                            'Start searching',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        )
                      : Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'Recent Searches',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Wrap(
                                spacing: 8,
                                children: _searchHistory.map((query) {
                                  return ActionChip(
                                    label: Text(query),
                                    onPressed: () {
                                      _searchController.text = query;
                                      _search(query);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                : _filteredResults.isEmpty
                ? Center(
                    child: Text(
                      'No expenses found',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredResults.length,
                    itemBuilder: (context, index) {
                      return ExpenseCard(
                        expense: _filteredResults[index],
                        onDelete: (_) {},
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
