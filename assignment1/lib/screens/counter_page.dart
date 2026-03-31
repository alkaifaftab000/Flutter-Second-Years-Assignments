import 'package:flutter/material.dart';

import '../widgets/gradient_button.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _increment() => setState(() => _count++);

  void _decrement() => setState(() => _count--);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Counter value: $_count',
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GradientButton(
                    text: 'Increment',
                    onPressed: _increment,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GradientButton(
                    text: 'Decrement',
                    onPressed: _decrement,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
