import 'package:flutter/material.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  static const tabTitles = ['Home', 'Profile'];

  Widget _buildTabContent() {
    if (currentIndex == 0) {
      return const MainTab();
    }
    return const ProfileTab();
  }

  void _openDetailsFromTab() {
    final message = 'Data from tab: ${tabTitles[currentIndex]}';
    Navigator.pushNamed(context, DetailsScreen.routeName, arguments: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text('Home Screen')),
      body: _buildTabContent(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openDetailsFromTab,
        icon: const Icon(Icons.open_in_new),
        label: const Text('Open Details'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tab 1'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tab 2'),
        ],
        onTap: (newIndex) => setState(() => currentIndex = newIndex),
      ),
    );
  }
}

class MainTab extends StatelessWidget {
  const MainTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.topCenter,
      child: const Text(
        'Simple main tab content',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.topCenter,
      child: const Text(
        'Simple profile tab content',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
